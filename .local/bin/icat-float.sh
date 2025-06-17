#!/bin/bash

img="$1"
basename=$(basename "$img")
name="${basename%.*}-float"

# Open new kitty window with kitten icat
kitty --title "$name" sh -c "kitten icat '$img'; read -p 'Press enter to close...'"
