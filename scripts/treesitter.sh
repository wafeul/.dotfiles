#!/usr/bin/env bash

set -euo pipefail

TREE_SITTER_VERSION="0.27.0"
CARGO_BIN="${HOME}/.cargo/bin"
TREE_SITTER_BIN="${CARGO_BIN}/tree-sitter"

echo "==> Installing Tree-sitter CLI ${TREE_SITTER_VERSION}"

# ------------------------------------------------------------
# Debian/system dependencies
# ------------------------------------------------------------

if command -v apt-get >/dev/null 2>&1; then
	echo "==> Installing required system packages"

	sudo apt-get update
	sudo apt-get install -y \
		build-essential \
		curl
else
	echo "ERROR: apt-get not found."
	echo "This installer currently supports Debian/Ubuntu-based systems."
	exit 1
fi

# ------------------------------------------------------------
# Rust / Cargo
# ------------------------------------------------------------

if command -v rustup >/dev/null 2>&1; then
	echo "==> rustup already installed"
else
	echo "==> Installing rustup"

	curl --proto '=https' --tlsv1.2 -sSf \
		https://sh.rustup.rs | sh -s -- -y
fi

# Load rustup environment for this script.
if [[ -f "${HOME}/.cargo/env" ]]; then
	# shellcheck disable=SC1091
	source "${HOME}/.cargo/env"
else
	echo "ERROR: ${HOME}/.cargo/env was not created."
	exit 1
fi

# Make sure we are using rustup's toolchain rather than an
# older system/Conda Cargo installation.
export PATH="${CARGO_BIN}:${PATH}"
BASHRC="${HOME}/.bashrc"
CARGO_PATH='export PATH="$HOME/.cargo/bin:$PATH"'

if ! grep -qF "$CARGO_PATH" "$BASHRC"; then
	echo "$CARGO_PATH" >>"$BASHRC"
fi

echo "==> Rust:"
rustc --version

echo "==> Cargo:"
cargo --version

# Make sure rustup has a current stable toolchain.
echo "==> Updating Rust stable toolchain"
rustup toolchain install stable
rustup default stable

# ------------------------------------------------------------
# Tree-sitter CLI
# ------------------------------------------------------------

if [[ -x "${TREE_SITTER_BIN}" ]]; then
	INSTALLED_VERSION="$("${TREE_SITTER_BIN}" --version | awk '{print $3}')"

	if [[ "${INSTALLED_VERSION}" == "${TREE_SITTER_VERSION}" ]]; then
		echo "==> Tree-sitter ${INSTALLED_VERSION} already installed"
	else
		echo "==> Installing Tree-sitter ${TREE_SITTER_VERSION}"
		cargo install tree-sitter-cli \
			--version "${TREE_SITTER_VERSION}" \
			--locked \
			--force
	fi
else
	echo "==> Installing Tree-sitter ${TREE_SITTER_VERSION}"

	cargo install tree-sitter-cli \
		--version "${TREE_SITTER_VERSION}" \
		--locked
fi

# ------------------------------------------------------------
# Verification
# ------------------------------------------------------------

if [[ ! -x "${TREE_SITTER_BIN}" ]]; then
	echo "ERROR: Tree-sitter installation failed."
	exit 1
fi

echo
echo "==> Tree-sitter:"
"${TREE_SITTER_BIN}" --version

echo
echo "==> Installation complete."
echo "Tree-sitter installed at:"
echo "  ${TREE_SITTER_BIN}"
