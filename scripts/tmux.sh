#!/bin/bash

# Use the icons defined in install.sh
# $CHECK, $FAIL, and $INFO are already set by install.sh

TMUX_CATPPUCCIN_ARCHIVE="./tmux/catppuccin_tmux.tgz"
TMUX_CATPPUCCIN_DESTINATION="$HOME/.tmux/plugins/"

source "$(dirname "${BASH_SOURCE[0]}")/../config.sh"

# Check if tmux is installed
if ! command -v tmux &>/dev/null; then
    echo "$FAIL tmux is not installed. Attempting to install tmux..."
    install_package tmux
    if command -v tmux &>/dev/null; then
        echo "$CHECK tmux successfully installed."
    else
        echo "$FAIL tmux installation failed."
        exit 1
    fi
else
    echo "$INFO tmux is already installed."
fi

# Install Tmux Plugin Manager (TPM)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "$INFO Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "$CHECK TPM installed successfully."
else
    echo "$INFO TPM is already installed."
fi

# Install tmuxifier
if [ ! -d "$HOME/.tmuxifier" ]; then
    echo "$INFO Installing tmuxifier..."
    git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
    echo "$CHECK tmuxifier installed successfully."
else
    echo "$INFO tmuxifier is already installed."
fi

# Copy tmux configuration file
if [ -f "./tmux/.tmux.conf" ]; then
    echo "$INFO Copying tmux configuration..."
    cp ./tmux/.tmux.conf "$HOME/.tmux.conf"
    echo "$CHECK tmux configuration copied successfully."
else
    echo "$FAIL No tmux configuration found in the installer directory."
fi

# Add tmuxifier initialization to .bashrc if not already present
if ! grep -q "tmuxifier" "$HOME/.bashrc"; then
    echo "$INFO Adding tmuxifier initialization to .bashrc..."
    echo 'export PATH="$HOME/.tmuxifier/bin:$PATH"' >> "$HOME/.bashrc"
    echo 'eval "$(tmuxifier init -)"' >> "$HOME/.bashrc"
    echo "$CHECK tmuxifier initialization added to .bashrc."
else
    echo "$INFO tmuxifier is already initialized in .bashrc."
fi

# Copy tmuxifier layouts if necessary
if [ -d "./tmux/tmuxifier" ]; then
    echo "$INFO Copying tmuxifier layouts..."
    cp -r ./tmux/tmuxifier/* ~/.tmuxifier/layouts/
    echo "$CHECK tmuxifier layouts copied successfully."
else
    echo "$FAIL No tmuxifier layouts found in the installer directory."
fi


# Check and install Clipboard utilities.
echo -e "$INFO Checking clipboard utilities..."
if pgrep -x "Xorg" >/dev/null && ! command -v xclip &>/dev/null; then
    echo -e "$INFO Installing xclip for X11..."
    install_package xclip
elif pgrep -x "wayland" >/dev/null && ! command -v wl-copy &>/dev/null; then
    echo -e "$INFO Installing wl-clipboard for Wayland..."
    install_package wl-clipboard
else
    echo -e "$CHECK Clipboard utilities are already installed."
fi

# Extract catppuccin_tmux.tgz archive
if [ -f "$TMUX_CATPPUCCIN_ARCHIVE" ]; then
    echo "$INFO Extracting catppuccin_tmux.tgz to $TMUX_CATPPUCCIN_DESTINATION..."
    mkdir -p "$TMUX_CATPPUCCIN_DESTINATION"
    tar -xzf "$TMUX_CATPPUCCIN_ARCHIVE" -C "$TMUX_CATPPUCCIN_DESTINATION"
    if [ $? -eq 0 ]; then
        echo "$CHECK catppuccin_tmux successfully extracted."
    else
        echo "$FAIL Failed to extract catppuccin_tmux.tgz."
    fi
else
    echo "$FAIL Archive $TMUX_CATPPUCCIN_ARCHIVE not found."
fi
