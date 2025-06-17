#!/bin/bash

TARGET_FILE=$HOME/.config/rofi/config.rasi


if [[ -f $1 ]]; then
  source $1
else
  echo "Error: .dcol file not found at $1"
  exit 1
fi



dcol_keys=(
  dcol_txt1
  dcol_pry2
  dcol_pry4
  dcol_1xa5
  dcol_pry1
)

rofi_keys=(
    foreground
    input-clr
    border-color
    selected
    list-bg
)
for i in "${!dcol_keys[@]}"; do
  dcol_var="${dcol_keys[$i]}"
  color_value="${!dcol_var}"
  rofi_key="${rofi_keys[$i]}"

  # Escape hash if present and make sure to prefix color with #
  # if [[ "$rofi_key" == "list-bg" ]]; then
  #   alpha="CC"  # ~80% opacity
  #   color_hex="#${color_value}${alpha}"
  # else
  color_hex="#$color_value"
  # fi

  # Use sed to replace the value (assuming format: key: #XXXXXX;)
  sed -i -E "s/^(\s*${rofi_key}\s*:\s*)#[0-9A-Fa-f]{6}/\1${color_hex}/" "$TARGET_FILE"
done



# if [[ -z "$1" || -z "$2" || ! -f "$2" ]]; then
#     echo "Usage: $0 /path/to/input/image /path/to/output/image"
#     exit 1
# fi

# if [[ "${2##*.}" =~ [Gg][Ii][Ff] ]]; then
#     echo "Detected GIF – extracting and cropping first frame..."
#     magick "$2[0]" -gravity center -crop 720x480+0+50 +repage ~/.cache/rofi-bg.jpg
# else
#     echo "Detected static image – cropping..."
#     magick "$2" -gravity center -crop 720x480+0+50 +repage ~/.cache/rofi-bg.jpg
# fi



# # Escape for sed
# escaped_path=$(printf '%s\n' "$2" | sed 's/[\/&]/\\&/g')

# # Simulate a line from the file
# sed -i -E "s|url\(\"[^\"]*\"|url(\"$escaped_path\"|" "$TARGET_FILE"
