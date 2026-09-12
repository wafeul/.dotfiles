# Use the icons defined in install.sh
# $CHECK, $FAIL, and $INFO are already set by install.sh

source "$(dirname "${BASH_SOURCE[0]}")/../config.sh"

# Check if opencode is already installed
if command -v opencode &>/dev/null; then
    echo "$INFO OpenCode is already installed."
else
    echo "$INFO Installing OpenCode..."
    curl -fsSL https://opencode.ai/install | bash
    echo "$CHECK OpenCode installed successfully."
fi

