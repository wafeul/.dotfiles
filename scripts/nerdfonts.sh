#!/bin/bash

set -e

source "$(dirname "${BASH_SOURCE[0]}")/../config.sh"

FONT_NAME="DejaVuSansMono"
FONT_ZIP="${FONT_NAME}.zip"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_ZIP}"
FONT_DIR="$HOME/.local/share/fonts"

echo "[*] Installing $FONT_NAME Nerd Font..."

mkdir -p "$FONT_DIR"
cd "$FONT_DIR"

# Download the font zip (if it doesn't exist)
if [ ! -f "$FONT_ZIP" ]; then
    curl -fLo "$FONT_ZIP" "$FONT_URL" || {
        echo "$FAIL Failed to download $FONT_NAME Nerd Font."
        exit 1
    }
fi

# Unzip it
unzip -o "$FONT_ZIP" -d "$FONT_NAME"

# Clean up the zip
rm -f "$FONT_ZIP"

# Refresh font cache
fc-cache -fv "$FONT_DIR"

# Confirm font install
if fc-list | grep -i "$FONT_NAME" &>/dev/null; then
    echo "$CHECK $FONT_NAME Nerd Font installed successfully."
    exit 0
else
    echo "$FAIL Font installation failed (not found in fc-list)."
    exit 1
fi
