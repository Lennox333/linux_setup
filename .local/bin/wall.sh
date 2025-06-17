#!/bin/bash

# Run sww with all arguments
swww img $1 --transition-type center

# Find the value of the 'img' argument
# for i in "$@"; do
#     if [[ $prev == "img" ]]; then
#         img="$i"
#         break
#     fi
#     prev="$i"
# done

# If img is found, run wal, change kitty theme
if [[ -n $1 ]]; then
  wal -n -i "$1" --cols16
  # --saturate 0.7
else
  echo "No 'img' argument found. wal not run."
fi

# run cava theme, wallbash.sh , swap cava update config
outdir="$HOME/Wallpapers/Wall-Dcol"

if [[ ! -d "$outdir" ]]; then
  mkdir -p "$outdir"
  echo "Created directory: $outdir"
fi

imgFile=$(basename "$1")
dcol="$outdir/$imgFile.dcol"

# if find $HOME/Wallpapers -name

if [[ -x "$(command -v wallbash.sh)" && -x "$(command -v cava_swap.sh)" ]]; then
  wallbash.sh -v -dir "$outdir" -i "$1" &&
    cava_swap.sh "$dcol"
else
  echo "Warning: wallbash.sh or cava_swap.sh not found or not executable."
fi
# wall_rofi.sh $dcol $1 && \
