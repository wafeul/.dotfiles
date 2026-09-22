#!/bin/bash

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LAZY_CONFIG_FILE="$REPO_ROOT/nvim/lazygit/config.yml"
NVIM_CONFIG_FOLDER="$REPO_ROOT/nvim/nvim"
PHPACTOR_CONFIG_FILE="$REPO_ROOT/nvim/phpactor.json"

# Source install_package and shared variables from config.sh
source "$REPO_ROOT/config.sh"

# Check if the current user is valid
current_user=$(whoami)

# Check if Neovim is already installed
if ! nvim -v &>/dev/null; then
    echo "NeoVim is not installed on this machine. It will be installed first."

    # Check if curl is installed, and install if necessary
    if ! curl -v &>/dev/null; then
        echo "This script requires curl to install Neovim. Installing curl..."
        install_package curl
    fi

    # Download and install the latest Neovim release (Linux x86_64 tar.gz)
    echo "[$INFO] Downloading latest Neovim..."
    curl -Lo /tmp/nvim-linux-x86_64.tar.gz \
        https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

    echo "[$INFO] Installing Neovim to /opt/nvim-linux-x86_64..."
    sudo rm -rf /opt/nvim-linux-x86_64
    sudo tar -C /opt -xzf /tmp/nvim-linux-x86_64.tar.gz
    rm -f /tmp/nvim-linux-x86_64.tar.gz

    # Expose nvim on PATH without requiring /opt to be on it
    sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

    echo "[$CHECK] Neovim has been installed. You can launch it with '/usr/local/bin/nvim'."

    # Offer user the option to create an alias for nvim
    echo "Do you want to create an alias for nvim?"
    select alias in "vi" "nvim" "no"; do
        case $alias in
        no) break ;;
        vi)
            echo "alias vi='/usr/local/bin/nvim'" >>~/.bash_aliases
            break
            ;;
        nvim)
            echo "alias nvim='/usr/local/bin/nvim'" >>~/.bash_aliases
            break
            ;;
        esac
    done

    # Offer user the option to create an alias for nvim diff mode
    echo "Do you want to create an alias for nvim diff mode?"
    select alias_diff in "vimdiff" "nvimdiff" "no"; do
        case $alias_diff in
        no) break ;;
        vimdiff)
            echo "alias vimdiff='/usr/local/bin/nvim -d'" >>~/.bash_aliases
            break
            ;;
        nvimdiff)
            echo "alias nvimdiff='/usr/local/bin/nvim -d'" >>~/.bash_aliases
            break
            ;;
        esac
    done
fi

# Install required software: composer, npm, fd-find, ripgrep, and lazygit
echo "Checking if required software is installed..."

# Check for the software and install if not present
for soft in "composer" "npm" "rg" "fdfind"; do
    if ! $soft --version &>/dev/null; then
        case $soft in
        "rg")
            soft="ripgrep"
            ;;
        "fdfind")
            soft="fd-find"
            ;;
        esac
        echo "$soft is not installed. Installing $soft..."
        install_package $soft
    fi
done

# tree-sitter-cli is required by nvim-treesitter (>= 0.26.1). Install it via the
# dedicated script so the CLI bootstrap can be maintained/tested independently.
bash "$REPO_ROOT/scripts/tree-sitter.sh"

# Handle LazyGit installation
if ! lazygit --version &>/dev/null; then
    echo "Lazygit is not installed. Installing Lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit lazygit.tar.gz

    # Configure LazyGit if necessary
    if [ -s ~/.config/lazygit/config.yml ] &>/dev/null; then
        echo "Your LazyGit config is not empty. Do you wish to replace it with the one from this repo?"
        select yn in "Yes" "No"; do
            case $yn in
            Yes)
                cp $LAZY_CONFIG_FILE ~/.config/lazygit/config.yml
                break
                ;;
            No) break ;;
            esac
        done
    else
        cp $LAZY_CONFIG_FILE ~/.config/lazygit/config.yml
    fi
fi

# Handle Neovim configuration
if [ -d ~/.config/nvim ]; then
    echo "Saving old Neovim config and installing a new one."
    tar -czf ~/.config/nvim-old-config.tgz ~/.config/nvim 2>/dev/null
    rm -rf ~/.config/nvim
    echo "Old Neovim config saved in ~/.config/nvim-old-config.tgz"
fi

# Handle phpactor stubs
if [ ! -d ~/.config/phpactor ]; then
    echo "Creating phpactor config folder..."
    mkdir -p ~/.config/phpactor
fi
if [ ! -f ~/.config/phpactor/phpactor.json ]; then
    echo "Copying phpactor.json file..."
    cp "$PHPACTOR_CONFIG_FILE" ~/.config/phpactor/phpactor.json
fi

cp -r "$NVIM_CONFIG_FOLDER" ~/.config/
echo "Neovim installation and configuration completed!"
