#!/usr/bin/env bash
# CACHE_FILE="$HOME/.cache/rofi_theme.conf"
# ROFI_DIR="$HOME/.config/rofi/launchers"

# if [[ ! -f "$CACHE_FILE" ]]; then
#     rofi -show drun
# fi

# if [[ -n "$1" && -n "$2" ]]; then
#     mkdir -p "$(dirname "$CACHE_FILE")"
#     echo "ROFI_TYPE=$1" > "$CACHE_FILE"
#     echo "ROFI_STYLE=$2" >> "$CACHE_FILE"
# fi



# source "$CACHE_FILE"

# rofi -show drun \
#     -theme "${ROFI_DIR}/type-${ROFI_TYPE}/style-${ROFI_STYLE}.rasi"


rofi -show drun -theme $HOME/.config/rofi/config.rasi