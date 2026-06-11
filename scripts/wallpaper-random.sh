#!/bin/bash

WALLPAPER_DIR="$HOME/.local/share/dotfiles/wallpapers"
WALLPAPER=$(find -L "$WALLPAPER_DIR" -type f | shuf -n 1)

pkill swaybg
swaybg -i "$WALLPAPER" &
