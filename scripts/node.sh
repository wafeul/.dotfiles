#!/bin/bash
# nvm.sh: Install NVM and Node.js for the current user
# This script assumes $DISTRO is passed from the main install.sh

# Source configuration
if [ -f config.sh ]; then
    source config.sh
else
    echo "$FAIL config.sh not found! Ensure it's in the parent directory."
    exit 1
fi

# Verify required variables from config.sh
if [[ -z $NVM_VERSION || -z $NODE_VERSION ]]; then
    echo "$FAIL NVM_VERSION or NODE_VERSION not set in config.sh."
    exit 1
fi

# Check if Node.js is already installed with the correct version
if command -v node &>/dev/null && [[ $(node -v) == "v$NODE_VERSION" ]]; then
    echo "$CHECK Node.js version $NODE_VERSION is already installed. Skipping installation."
else
    echo "$INFO Installing Node.js version $NODE_VERSION..."

    # Check if nvm is already installed
    if [ -d "$HOME/.nvm" ] && command -v nvm &>/dev/null; then
        echo "$CHECK NVM is already installed."
    else
        echo "$INFO Downloading and installing NVM version $NVM_VERSION..."
        curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash

        # Source nvm to the current shell
        NVM_DIR="$HOME/.nvm"
        export NVM_DIR
        # shellcheck disable=SC1090
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

        if ! command -v nvm &>/dev/null; then
            echo "$FAIL NVM installation failed. Please check the logs and try again."
            exit 1
        fi

        echo "$CHECK NVM installed successfully."
    fi

    # Install Node.js
    nvm install "$NODE_VERSION"

    # Verify the Node.js installation
    if ! command -v node &>/dev/null || [[ ! "$(node -v)" =~ ^v$NODE_VERSION\..* ]]; then
        echo -e "$FAIL Node.js installation failed. Please check the logs and try again."
        exit 1
    fi

    echo "$CHECK Node.js version $NODE_VERSION installed successfully."

    # Add nvm sourcing to shell startup scripts
    if ! grep -q 'export NVM_DIR="$HOME/.nvm"' ~/.bashrc; then
        echo "$INFO Adding NVM setup to ~/.bashrc..."
        echo 'export NVM_DIR="$HOME/.nvm"' >>~/.bashrc
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >>~/.bashrc
        echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >>~/.bashrc
    fi
fi

# Verify npm version
if command -v npm &>/dev/null; then
    echo "$CHECK npm version $(npm -v) is installed."
else
    echo "$FAIL npm installation failed or not found."
    exit 1
fi

echo "$CHECK NVM and Node.js setup completed. Restart your terminal or run: source ~/.bashrc"
