#!/bin/bash

set -euo pipefail

DOTFILES_PATH=$(dirname "$(realpath "$0")")
LOCAL_SHARE="$HOME"/.local/share/dotfiles

mkdir -p "$LOCAL_SHARE"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/share/nvim/site/parser"

# Install packages
sudo pacman -S --needed - < "$DOTFILES_PATH"/packages/core 
sudo pacman -S --needed - < "$DOTFILES_PATH"/packages/dev
sudo pacman -S --needed - < "$DOTFILES_PATH"/packages/fonts
sudo pacman -S --needed - < "$DOTFILES_PATH"/packages/apps
sudo pacman -S --needed - < "$DOTFILES_PATH"/packages/desktop
sudo pacman -S --needed - < "$DOTFILES_PATH"/packages/misc

# Link directories
ln -sfn "$DOTFILES_PATH"/config/fuzzel "$HOME"/.config/fuzzel
ln -sfn "$DOTFILES_PATH"/config/ghostty "$HOME"/.config/ghostty
ln -sfn "$DOTFILES_PATH"/config/niri "$HOME"/.config/niri
ln -sfn "$DOTFILES_PATH"/config/nvim "$HOME"/.config/nvim
ln -sfn "$DOTFILES_PATH"/config/quickshell "$HOME"/.config/quickshell
ln -sfn "$DOTFILES_PATH"/scripts "$LOCAL_SHARE"/scripts
ln -sfn "$DOTFILES_PATH"/wallpapers "$LOCAL_SHARE"/wallpapers

# Finish neovim setup 
source "$DOTFILES_PATH"/install-scripts/install-nvim-parsers.sh

# Finsih niri setup
source "$DOTFILES_PATH"/install-scripts/niri-monitor-config.sh
