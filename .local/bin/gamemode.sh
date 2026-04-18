#!/usr/bin/env bash
# TODO: Add persistent mode
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | sed -n '1p' | awk '{print $2}')

enable() {
  hyprctl -q --batch "\
        keyword animations:enabled 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:shadow:xray 1;\
        keyword decoration:blur:enabled 0;\
      #  keyword general:gaps_in 0;\
       # keyword general:gaps_out 0;\
       # keyword general:border_size 1;\
       # keyword decoration:rounding 0 ;\
        keyword decoration:active_opacity 1.5 ;\
        keyword decoration:inactive_opacity 1.5 ;\
        keyword decoration:fullscreen_opacity 1 ;\
        keyword decoration:fullscreen_opacity 1 ;\
        keyword layerrule noanim,waybar ;\
        keyword layerrule noanim,swaync-notification-window ;\
        keyword layerrule noanim,swww-daemon ;\
        keyword layerrule noanim,rofi
        "
  #hyprctl 'keyword windowrule opaque,class:(.*)' # ensure all windows are opaque
  # powerprofilesctl set performance
}

disable() {
  hyprctl reload config-only -q

}

case "$1" in
on)
  if [ "$HYPRGAMEMODE" = 1 ]; then
    enable
  fi
  ;;
off)
  if [ "$HYPRGAMEMODE" = 0 ]; then
    disable
  fi
  ;;
*)
  if [ "$HYPRGAMEMODE" = 1 ]; then
    enable
  else
    disable
  fi
  ;;
esac
