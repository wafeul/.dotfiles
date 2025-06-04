#!/bin/bash

set -e

echo -e "\n[*] Dotfiles installer starting..."

# Define a list of essential tools
ESSENTIAL_TOOLS=("fc-cache" "unzip")

# Function to check and install missing tools
check_and_install_tools() {
    for tool in "${ESSENTIAL_TOOLS[@]}"; do
        if ! command -v "$tool" &>/dev/null; then
            echo "$INFO Installing missing tool: $tool"
            install_package "$tool"
            if ! command -v "$tool" &>/dev/null; then
                echo "$FAIL Failed to install $tool. Exiting..."
                exit 1
            fi
            echo "$CHECK $tool installed successfully."
        else
            echo "$INFO $tool is already installed."
        fi
    done
}

# Call the function early in the script
check_and_install_tools

#Try installing Nerd Font first
if fc-list | grep -qi "DejaVuSansMono"; then
    USE_ICONS=true
    echo -e "\n[✅] DejaVuSansMono Nerd Font is already installed."
else
    bash scripts/nerdfonts.sh && USE_ICONS=true || USE_ICONS=false
fi

if [ "$USE_ICONS" = true ]; then
    CHECK="[✅]"
    FAIL="[❌]"
    INFO="[ℹ️]]"
else
    CHECK="[OK]"
    FAIL="[ERR]"
    INFO="[>>]"
fi

echo -e "\n$CHECK Nerd Font status: $([ "$USE_ICONS" = true ] && echo "enabled" || echo "fallback to ASCII mode")"

# Detect distro and store it in variables
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
    DISTRO_LIKE=$ID_LIKE
else
    echo "$FAIL Unsupported distribution: cannot detect OS."
    exit 1
fi

echo "$CHECK Detected OS: $DISTRO ($DISTRO_LIKE)"

# Define install_package function to work across distros
install_package() {
    if command -v apt &>/dev/null; then
        sudo apt update && sudo apt install -y "$@"
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y "$@"
    elif command -v yum &>/dev/null; then
        sudo yum install -y "$@"
    else
        echo "$FAIL No supported package manager found (apt/dnf/yum)."
        exit 1
    fi
}

# Step-by-step interactive install of components
scripts=(
    xfce.sh
    bashrc.sh
    tmux.sh
    wallpaper.sh
    lsd.sh
    nvim.sh
    setup_environment.sh
    node.sh
)

for script in "${scripts[@]}"; do
    echo -e "\nDo you want to run: ${script}?"
    select yn in "Yes" "No"; do
        case $yn in
        Yes)
            bash "scripts/${script}" "$DISTRO"
            break
            ;;
        No) break ;;
        esac
    done
done

echo -e "\n$CHECK Dotfiles installation complete!"
