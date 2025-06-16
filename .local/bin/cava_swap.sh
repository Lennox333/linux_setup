#!/bin/bash

# DCOL_FILE=
TARGET_FILE=$HOME/.config/cava/config

# Define the dcol variable names in the order you want them assigned
dcol_keys=(
  dcol_pry1
  dcol_pry2
  dcol_pry3
  dcol_pry4
)

# Loop through and update gradient_color_1 to _8
for i in "${!dcol_keys[@]}"; do
  key="${dcol_keys[$i]}"
  index=$((i + 1))
  # Extract color value from dcol file (strip quotes)
  color=$(grep "^$key=" "$1" | cut -d= -f2 | tr -d '"')
  #   echo $color
  # Replace in target file
  sed -i "s|^\(gradient_color_${index} *= *\).*|\1'#${color}'|" "$TARGET_FILE"
done

pkill -USR2 cava >/dev/null 2>&1 &
disown
