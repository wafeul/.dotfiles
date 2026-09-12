# Use the icons defined in install.sh
# $CHECK, $FAIL, and $INFO are already set by install.sh

source "$(dirname "${BASH_SOURCE[0]}")/../config.sh"

# Check if opencode is already installed for the target user
if sudo -u "$REAL_USER" env HOME="$REAL_HOME" PATH="$REAL_HOME/.opencode/bin:$PATH" \
	command -v opencode &>/dev/null; then
	echo "$INFO OpenCode is already installed."
else
	echo "$INFO Installing OpenCode for $REAL_USER..."

	sudo -u "$REAL_USER" env HOME="$REAL_HOME" \
		bash -c 'curl -fsSL https://opencode.ai/install | bash'

	echo "$CHECK OpenCode installed successfully."
fi

echo "$INFO Setting up OpenCode..."

BASHRC="$REAL_HOME/.bashrc"
OPENCODE_PATH='export PATH="$HOME/.opencode/bin:$PATH"'

if ! grep -qF "$OPENCODE_PATH" "$BASHRC" 2>/dev/null; then
	echo "$OPENCODE_PATH" >>"$BASHRC"
	chown "$REAL_USER:$REAL_USER" "$BASHRC"
	echo "$INFO Added OpenCode to PATH in $BASHRC"
fi

# Configure opencode to use gitnexus through mcp
echo '
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "gitnexus": {
      "command": "npx",
      "args": ["-y", "gitnexus@latest", "mcp"]
    }
  }
}
' | sudo -u "$REAL_USER" tee "$REAL_HOME/.opencode/config.json" >/dev/null
