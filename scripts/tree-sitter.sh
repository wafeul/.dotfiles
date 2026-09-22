#!/bin/bash

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$REPO_ROOT/config.sh"

# tree-sitter-cli is required by nvim-treesitter (>= 0.26.1).
# Preferred order: existing usable binary, distro package, prebuilt binary (only
# if it runs on this machine's glibc), then a source build via cargo (works on
# any glibc).
TS_REQ="0.26.1"

ts_version_ge() {
    [[ "$1" == "$2" || "$(printf '%s\n' "$1" "$2" | sort -V | head -n1)" == "$2" ]]
}
ts_print_version() {
    command -v tree-sitter &>/dev/null &&
        tree-sitter --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n1 || true
}

have="$(ts_print_version)"
if [[ -n "$have" ]] && ts_version_ge "$have" "$TS_REQ"; then
    echo "$CHECK tree-sitter-cli $have is installed."
    exit 0
fi

echo "$INFO Installing tree-sitter-cli >= $TS_REQ..."

# 1) Distro package (update/install may fail if the package is missing)
if install_package tree-sitter-cli 2>/dev/null; then
    have="$(ts_print_version)"
    if [[ -n "$have" ]] && ts_version_ge "$have" "$TS_REQ"; then
        echo "$CHECK tree-sitter-cli installed via distro package: $have"
        exit 0
    fi
    echo "$INFO Distro package provides too old a version ($have)."
fi

# 2) Prebuilt binary -- verify it actually RUNS (it needs glibc >= 2.39)
echo "$INFO Trying prebuilt tree-sitter-cli binary."
curl -Lo /tmp/tree-sitter-cli.zip \
    https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-cli-linux-x64.zip
sudo unzip -o /tmp/tree-sitter-cli.zip -d /usr/local/bin
rm -f /tmp/tree-sitter-cli.zip
have="$(ts_print_version)"
if [[ -n "$have" ]] && ts_version_ge "$have" "$TS_REQ"; then
    echo "$CHECK tree-sitter-cli installed via prebuilt binary: $have"
    exit 0
fi

# 3) Source build via cargo -- links against this machine's libc
echo "$INFO Prebuilt binary is incompatible (glibc too old); building tree-sitter-cli from source."
if command -v apt &>/dev/null; then
    install_package build-essential
elif command -v dnf &>/dev/null || command -v yum &>/dev/null; then
    install_package gcc-c++ make
fi
if ! command -v git &>/dev/null; then
    install_package git
fi

if ! command -v cargo &>/dev/null; then
    echo "$INFO Installing Rust toolchain via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable >/dev/null
    . "$HOME/.cargo/env"
fi

if ! cargo install tree-sitter-cli --version "$TS_REQ"; then
    echo "$INFO Distro cargo/rustc too old; installing latest stable via rustup and retrying..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable >/dev/null
    . "$HOME/.cargo/env"
    cargo install tree-sitter-cli --version "$TS_REQ"
fi
sudo install -m 755 "$HOME/.cargo/bin/tree-sitter" /usr/local/bin/tree-sitter

have="$(ts_print_version)"
if [[ -z "$have" ]] || ! ts_version_ge "$have" "$TS_REQ"; then
    echo "$FAIL tree-sitter-cli installation failed."
    exit 1
fi
echo "$CHECK tree-sitter-cli installed from source: $have"