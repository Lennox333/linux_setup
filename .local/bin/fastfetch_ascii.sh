#!/usr/bin/env bash

# if [ -z "${*}" ]; then
#   clear
#   exec fastfetch --logo-type kitty
#   exit
# fi

# Folder with ASCII text files
ASCII_DIR="$HOME/.config/fastfetch/ascii" # Change as needed

# Pick a random .txt file
ASCII_FILE=$(find "$ASCII_DIR" -type f -name "*.txt" | shuf -n 1)

ascii_height=$(wc -l < "$ASCII_FILE")

# echo $ascii_height
# Terminal dimensions
# term_width=$(tput cols)
term_height=$(tput lines)
# term_height=35
# echo $term_height
# Calculate padding to roughly center
# padding_left=$(( (term_width - ascii_width) / 2 ))
padding_top=$(( (term_height - ascii_height ) / 10 ))

# echo $padding_top
# Ensure non-negative padding
# padding_left=$((padding_left < 0 ? 0 : padding_left))
# padding_top=$((padding_top  > 20 ? 2 : padding_top))
padding_top=$((ascii_height - padding_top  > 12 ? 2 : padding_top))

# echo $padding_top

# If a file was found, run fastfetch with it
if [ -n "$ASCII_FILE" ]; then
  fastfetch --file "$ASCII_FILE" --logo-padding-left 5 --logo-padding-top "$padding_top"

else
  echo "No ASCII .txt files found in $ASCII_DIR"
  exit 1
fi
