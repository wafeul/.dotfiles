#!/bin/bash

# Set the path to the wallpaper folder
folder=$(realpath $(dirname $0))
pic=$(ls ${folder}/wallpapers/* | shuf -n1)

# Set the wallpaper for GNOME
gsettings set org.gnome.desktop.background picture-options 'scaled'
gsettings set org.gnome.desktop.background picture-uri "file://$pic"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$pic"
