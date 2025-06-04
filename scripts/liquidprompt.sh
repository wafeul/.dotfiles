#!/bin/bash

# Use the icons defined in install.sh
# $CHECK, $FAIL, and $INFO are already set by install.sh

source "$(dirname "${BASH_SOURCE[0]}")/../config.sh"

# Check if Liquidprompt is already installed
if [ -d "$HOME/.liquidprompt" ]; then
    echo "$INFO Liquidprompt is already installed."
else
    echo "$INFO Installing Liquidprompt..."
    git clone https://github.com/nojhan/liquidprompt.git "$HOME/.liquidprompt"
    echo "$CHECK Liquidprompt cloned successfully."

    # Add Liquidprompt initialization to .bashrc if not already present
    if ! grep -q "liquidprompt" "$HOME/.bashrc"; then
        echo "$INFO Adding Liquidprompt initialization to .bashrc..."
        cat <<EOF >>"$HOME/.bashrc"

# Liquidprompt initialization
if [ -f "$HOME/.liquidprompt/liquidprompt" ]; then
    source "$HOME/.liquidprompt/liquidprompt"
fi
EOF
        echo "$CHECK Liquidprompt initialization added to .bashrc."
    else
        echo "$INFO Liquidprompt is already initialized in .bashrc."
    fi
fi

# Check if Liquidprompt dependencies are installed
echo "$INFO Checking dependencies for Liquidprompt..."
for soft in bc gawk; do
    if ! command -v "$soft" &>/dev/null; then
        echo "$INFO Installing dependency: $soft..."
        install_package "$soft"
    else
        echo "$CHECK Dependency $soft is already installed."
    fi
done
