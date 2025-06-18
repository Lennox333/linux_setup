#!/bin/bash

#hyprctl clients to check
dontkilllist=("Steam" "PenTablet")

active_class=$(hyprctl activewindow -j | jq -r ".class")


if [[ " ${dontkilllist[@]} " =~ " ${active_class} " ]]; then
    xdotool windowunmap $(xdotool getactivewindow)
else
    hyprctl dispatch killactive ""
fi
