#!/bin/bash

STATE_FILE="/tmp/in_display_state"

# STATE_FILE="$HOME/.cache/in_display_state"

# Default to 1 if file not found
IN_DISPLAY=$(cat "$STATE_FILE" 2>/dev/null || echo 1)

if hyprctl monitors | grep -q "HDMI" && [ "$IN_DISPLAY" = 1 ]; then
    hyprctl keyword monitor eDP-1, disable
    # hyprctl dispatch dpms off eDP-1
    echo 0 >"$STATE_FILE"
else
    hyprctl keyword monitor eDP-1, auto
    # hyprctl dispatch dpms on eDP-1
    echo 1 >"$STATE_FILE"
fi

hyprctl keyword misc:disable_autoreload 1      