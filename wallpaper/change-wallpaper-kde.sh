#!/bin/bash

# Set the path to the wallpaper folder
folder=$(realpath $(dirname $0))
pic=$(ls ${folder}/wallpapers/* | shuf -n1)

# Set the wallpaper for KDE
plasma-apply-wallpaperimage "$pic"
