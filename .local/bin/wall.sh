#!/bin/bash

outdir="$HOME/Wallpapers/Wall-Dcol"

if [[ ! -d "$outdir" ]]; then
  mkdir -p "$outdir"
  echo "Created directory: $outdir"
fi

if [[ -z $1 ]]; then
  echo "no img found"
  exit 1
fi

imgFile=$(basename "$1")
dcol="$outdir/$imgFile.dcol"

# Run sww with all arguments

# If img is found, run wal, change kitty theme
if [[ ! -x "$(command -v wallbash.sh)" || ! -x "$(command -v wall_dcol_replace.sh)" || ! -x "$(command -v wall_hypr.sh)" ]]; then
  echo "Warning: one or more required scripts (wallbash.sh, wall_dcol_replace.sh, wall_hypr.sh) not found or not executable."
  exit 1
fi

swww img "$1" --transition-type center >/dev/null 2>&1 &

wallbash.sh -v -dir "$outdir" -i "$1" &&
  wall_dcol_replace.sh -f "$dcol" \
    -t "$HOME/.config/ags/src/style/colors.scss" \
    -i "dcol_4xa8_rgba" -o "color16" &&
  wal -n -i "$1" --cols16

# --saturate 0.7

wall_hypr.sh "$dcol" && hyprctl reload config-only -q

(
  wall_dcol_replace.sh -f "$dcol" \
    -t "$HOME/.config/cava/config" \
    -i "dcol_pry1, dcol_pry2, dcol_pry3, dcol_pry4" \
    -o "gradient_color_1, gradient_color_2, gradient_color_3 ,gradient_color_4" &&
    pkill -USR2 cava >/dev/null 2>&1
) &

(
  wall_dcol_replace.sh -f "$dcol" \
    -t "$HOME/.config/btop/themes/swww.theme" \
    -i "dcol_2xa1, \
  dcol_4xa9, \
  dcol_3xa8, \
  dcol_3xa9, \
  dcol_3xa9, \
  dcol_pry4, \
  dcol_3xa2, \
  dcol_4xa9, \
  dcol_2xa4, \
  dcol_4xa5, \
  dcol_pry2, \
  dcol_pry2, \
  dcol_pry2, \
  dcol_pry2, \
  dcol_pry2, \
  dcol_pry2, dcol_pry3, dcol_pry4, \
  dcol_4xa8, dcol_3xa6, dcol_pry4, \
  dcol_pry2, dcol_pry3, dcol_pry4, \
  dcol_3xa8, dcol_pry3, dcol_pry4, \
  dcol_3xa8, dcol_3xa6, dcol_3xa4, \
  dcol_3xa8, dcol_3xa6, dcol_3xa4, \
  dcol_3xa8, dcol_3xa6, dcol_3xa4, \
  dcol_3xa8, dcol_3xa6, dcol_3xa4, \
  dcol_3xa8, dcol_3xa6, dcol_3xa4" \
    -o "theme[main_bg], \
  theme[main_fg], \
  theme[hi_fg], \
  theme[graph_text], \
  theme[title], \
  theme[selected_bg], \
  theme[selected_fg], \
  theme[inactive_fg], \
  theme[meter_bg], \
  theme[proc_misc], \
  theme[cpu_box], \
  theme[mem_box], \
  theme[net_box], \
  theme[proc_box], \
  theme[div_line], \
  theme[temp_start], theme[temp_mid], theme[temp_end], \
  theme[cpu_start], theme[cpu_mid], theme[cpu_end], \
  theme[free_start], theme[free_mid], theme[free_end], \
  theme[cached_start], theme[cached_mid], theme[cached_end], \
  theme[available_start], theme[available_mid], theme[available_end], \
  theme[used_start], theme[used_mid], theme[used_end], \
  theme[download_start], theme[download_mid], theme[download_end], \
  theme[upload_start], theme[upload_mid], theme[upload_end]" &&
    pkill -USR2 btop >/dev/null 2>&1
) &
disown
