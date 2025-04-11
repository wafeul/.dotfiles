#!/bin/bash

# Load shared configuration
source ./config.sh

# Path to the user's lsd config directory and dotfiles config file
LSD_CONFIG_DIR="$HOME/.config/lsd"
DOTFILES_CONFIG="./lsd/config.yaml"

# Function to check if lsd is installed
if ! command -v lsd &>/dev/null; then
    echo -e "\n$INFO Installing lsd..."
    install_package lsd && echo -e "$CHECK lsd installed successfully!" || {
        echo -e "$FAIL Failed to install lsd."
        exit 1
    }
else
    echo -e "\n$CHECK lsd is already installed."
fi

# Add aliases to ~/.bash_aliases if not present
ALIASES_FILE="$HOME/.bash_aliases"
if ! grep -q "alias ls=" "$ALIASES_FILE"; then
    echo -e "\n$INFO Adding lsd aliases to $ALIASES_FILE..."
    cat <<EOF >>"$ALIASES_FILE"
# lsd aliases
alias ls='lsd'
alias ll='lsd -lhrth'
alias la='lsd -lhrtAh'
EOF
    echo -e "$CHECK Aliases added successfully!"
else
    echo -e "\n$INFO Aliases for lsd are already present in $ALIASES_FILE."
fi

# Ask user if they want to copy the config file
if [ -f "$DOTFILES_CONFIG" ]; then
    echo -e "\n$INFO Detected lsd configuration file in dotfiles: $DOTFILES_CONFIG"
    if [ -d "$LSD_CONFIG_DIR" ]; then
        read -p "Do you want to replace your existing lsd configuration? [y/N]: " response
    else
        read -p "lsd configuration folder is missing. Do you want to create it and apply the provided configuration? [y/N]: " response
    fi

    if [[ "$response" =~ ^[Yy]$ ]]; then
        mkdir -p "$LSD_CONFIG_DIR"
        cp "$DOTFILES_CONFIG" "$LSD_CONFIG_DIR/config.yaml"
        echo -e "$CHECK Configuration file copied to $LSD_CONFIG_DIR/config.yaml."
    else
        echo -e "$INFO Skipped copying the configuration file."
    fi
else
    echo -e "$FAIL lsd configuration file not found in dotfiles at $DOTFILES_CONFIG."
fi

# Final message
echo -e "\n$CHECK lsd setup complete!"
