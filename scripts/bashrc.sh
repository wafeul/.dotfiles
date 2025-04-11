#!/bin/bash

set -e

source "$(dirname "${BASH_SOURCE[0]}")/../config.sh"

echo "$CHECK Configuring .bashrc..."

# Backup and copy .bashrc
echo "$CHECK Backing up and copying .bashrc..."
if [ -f "$HOME/.bashrc" ]; then
    mv "$HOME/.bashrc" "$HOME/.bashrc.old"
    echo "$INFO Old .bashrc backed up as .bashrc.old"
fi
cp ./bash/.bashrc "$HOME/.bashrc"
echo "$CHECK .bashrc copied successfully."

# Only back up and copy .bash_aliases if a new one exists in the repo folder
if [ -f "./bash/.bash_aliases" ]; then
    if [ -f "$HOME/.bash_aliases" ]; then
        mv "$HOME/.bash_aliases" "$HOME/.bash_aliases.old"
        echo "$INFO Old .bash_aliases backed up as .bash_aliases.old"
    fi
    cp ./bash/.bash_aliases "$HOME/.bash_aliases"
    echo "$CHECK .bash_aliases copied successfully."
else
    echo "$FAIL No .bash_aliases found in the installer directory."
fi
