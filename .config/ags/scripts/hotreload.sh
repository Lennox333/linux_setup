#!/usr/bin/env bash

DIR="$HOME/.config/ags"
CONFIG_FILES=$(find "$DIR/" -type f -name "*.tsx" -o -name "*.ts")

# trap "pkill gjs" EXIT
find $CONFIG_FILES -type f | entr -r ags run

# while true; do
#     ags run &
#     inotifywait -e create,modify $CONFIG_FILES
#     pkill gjs
# done
