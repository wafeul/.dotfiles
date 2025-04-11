#!/bin/bash

source ./config.sh

echo -e "\n$INFO Configuring XFCE desktop environment..."

# Path to the custom configuration file
CUSTOM_CONF_FILE="$HOME/.dotfiles/xfce/terminalrc"
NORD_THEME_FILE="$HOME/.dotfiles/xfce/nord.theme"
XFCE_TERMINAL_CONF="$HOME/.config/xfce4/terminal/terminalrc"

# Install XFCE if missing
if ! command -v xfce4-terminal &>/dev/null; then
    echo "$INFO XFCE not found. Installing..."
    install_package xfce4-terminal
    echo "$CHECK XFCE installed successfully."

    # Ensure the target directory exists
    mkdir -p "$(dirname "$XFCE_TERMINAL_CONF")"

    # Check if the custom configuration file exists
    if [ -f "$CUSTOM_CONF_FILE" ]; then
        cp "$CUSTOM_CONF_FILE" "$XFCE_TERMINAL_CONF"
        echo "$CHECK Applied custom XFCE terminal configuration."
    else
        echo "$FAIL Custom configuration file not found: $CUSTOM_CONF_FILE"
    fi
else
    echo "$CHECK XFCE is already installed."
    echo -e "$INFO Would you like to apply the custom XFCE terminal configuration from the dotfiles?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes)
                # Ensure the target directory exists
                mkdir -p "$(dirname "$XFCE_TERMINAL_CONF")"
                
                # Check if the custom configuration file exists
                if [ -f "$CUSTOM_CONF_FILE" ]; then
                    cp "$CUSTOM_CONF_FILE" "$XFCE_TERMINAL_CONF"
                    echo "$CHECK Applied custom XFCE terminal configuration."
                else
                    echo "$FAIL Custom configuration file not found: $CUSTOM_CONF_FILE"
                fi
                break
                ;;
            No)
                echo "$INFO Skipping custom configuration."
                break
                ;;
        esac
    done
fi

echo -e "$INFO Do you wish to install nord.theme for XFCE terminal?"
select yn in "Yes" "No"; do
    case $yn in
        Yes)
            if [ ! -f $NORD_THEME_FILE ]; then
                echo "$FAIL Could not find nord.theme in $NORD_THEME_FILE \n"
            else
                if [ ! -d ~/.local/share/xfce4/terminal/colorschemes ]; then
                    mkdir -p ~/.local/share/xfce4/terminal/colorschemes
                fi
                cp $NORD_THEME_FILE ~/.local/share/xfce4/terminal/colorschemes
            fi
            break
            ;;
        No)
            break
            ;;
    esac
done

echo -e "$CHECK XFCE configuration completed!"
