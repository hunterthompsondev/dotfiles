#!/bin/bash

NIRI_DIR="$DOTFILES_PATH"/config/niri
files=("$NIRI_DIR"/local/*)

# Print list
for i in "${!files[@]}"; do
    echo "$((i+1)). $(basename "${files[$i]}")"
done
echo "$((${#files[@]}+1)). Skip (no monitor configuration)"

# Prompt for selection
printf "Select a niri monitor configuration file: "
read choice

# Validate and get selected file
if [ "$choice" -ge 1 ] && [ "$choice" -le "${#files[@]}" ]; then
    selected="${files[$((choice-1))]}"
    ln -sfn "$selected" "$NIRI_DIR/local-monitor-config.kdl"
elif [ "$choice" -eq "$((${#files[@]}+1))" ]; then
    echo "Skipping monitor configuration"
else
    echo "Invalid selection"
    exit 1
fi
