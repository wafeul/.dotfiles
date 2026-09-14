# Use the icons defined in install.sh
# $CHECK, $FAIL, and $INFO are already set by install.sh

source "$(dirname "${BASH_SOURCE[0]}")/../config.sh"

# # Check if Codex CLI is already installed for the target user
CODEX_BIN="$REAL_HOME/.local/bin/codex"

if [[ -x "$CODEX_BIN" ]]; then
	echo "$INFO Codex CLI is already installed."
else
	echo "$INFO Installing Codex CLI for $REAL_USER..."

	sudo -u "$REAL_USER" env \
		HOME="$REAL_HOME" \
		npm install -g --prefix "$REAL_HOME/.local" @openai/codex

	echo "$CHECK Codex CLI installed successfully."
fi

# Check if Codex ACP is already installed for the target user
CODEX_ACP_BIN="$REAL_HOME/.local/bin/codex-acp"

if [[ -x "$CODEX_ACP_BIN" ]]; then
	echo "$INFO Codex ACP is already installed."
else
	echo "$INFO Installing Codex ACP for $REAL_USER..."

	sudo -u "$REAL_USER" env \
		HOME="$REAL_HOME" \
		npm install -g --prefix "$REAL_HOME/.local" @agentclientprotocol/codex-acp

	echo "$CHECK Codex ACP installed successfully."
fi

# Install GitNexus for the target user
GITNEXUS_BIN="$REAL_HOME/.local/bin/gitnexus"

if [[ -x "$GITNEXUS_BIN" ]]; then
	echo "$INFO GitNexus is already installed."
else
	echo "$INFO Installing GitNexus for $REAL_USER..."

	sudo -u "$REAL_USER" env \
		HOME="$REAL_HOME" \
		npm install -g --prefix "$REAL_HOME/.local" gitnexus

	echo "$CHECK GitNexus installed successfully."
fi

echo "$INFO Ensuring user-local npm binaries are on PATH..."

BASHRC="$REAL_HOME/.bashrc"
LOCAL_BIN_PATH='export PATH="$HOME/.local/bin:$PATH"'

if ! grep -qF "$LOCAL_BIN_PATH" "$BASHRC" 2>/dev/null; then
	echo "$LOCAL_BIN_PATH" >>"$BASHRC"
	chown "$REAL_USER:$REAL_USER" "$BASHRC"
	echo "$INFO Added user-local npm binaries to PATH in $BASHRC"
fi
