#!/bin/bash

set -e
source "$(dirname "${BASH_SOURCE[0]}")/../config.sh"

echo "$CHECK Configuring wallpaper changer..."

# Ask the user if they want to set up wallpaper rotation
echo "Do you wish to change your wallpaper with dark-themed wallpapers changing every minute?"
select yn in "Yes" "No"; do
    case $yn in
    Yes )
        # Ensure both scripts are executable
        chmod +x "$HOME/.dotfiles/wallpaper/change-wallpaper-gnome.sh"
        chmod +x "$HOME/.dotfiles/wallpaper/change-wallpaper-kde.sh"

        # Detect the desktop environment
        desktop_env=$(echo $XDG_CURRENT_DESKTOP)

        # Set the appropriate cron job based on the environment
        uid=$(id -u)
        if [[ "$desktop_env" == "GNOME" || "$desktop_env" == "gnome" ]]; then
            cron_entry="* * * * * env DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/${uid}/bus $HOME/.dotfiles/wallpaper/change-wallpaper-gnome.sh"
        elif [[ "$desktop_env" == "KDE" || "$desktop_env" == "KDE Plasma" ]]; then
            cron_entry="* * * * * env DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/${uid}/bus $HOME/.dotfiles/wallpaper/change-wallpaper-kde.sh"
        else
            echo "$FAIL Unsupported Desktop Environment: $desktop_env"
            exit 1
        fi

        # Check if cron job already exists
        if ! crontab -l | grep -q "$cron_entry"; then
            # Add cron job if not already present
            crontab -l | { cat; echo "$cron_entry"; } | crontab -
            echo "$CHECK Wallpaper change script has been set up with cron."
        else
            echo "$INFO Cron job for wallpaper change already exists."
        fi
        break ;;
    No ) break ;;
    esac
done

