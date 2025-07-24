#!/bin/bash
# set -x 
while [[ $# -gt 0 ]]; do
  case "$1" in
  -t)
    if [[ -f $2 ]]; then
      TARGET_FILE="$2"
    else
      echo "Error: Target file not found at $2"
      exit 1
    fi
    shift 2
    ;;
  -f)
    if [[ -f $2 ]]; then
      source $2
    else
      echo "Error: .dcol file not found at $1"
      exit 1
    fi
    shift 2
    ;;
  -i)
    IFS=',' read -ra dcol_keys <<<"$(echo "$2" | tr -d ' ')"
    shift 2
    ;;
  -o)
    IFS=',' read -ra target_keys <<<"$(echo "$2" | tr -d ' ')"
    shift 2
    ;;
  *) break ;;
  esac
done

for i in "${!dcol_keys[@]}"; do
  dcol_var="${dcol_keys[$i]}"
  color_value="${!dcol_var}"
  target_key="${target_keys[$i]}"

  # echo $color_value
  # Escape hash if present and make sure to prefix color with #
  # if [[ "$target_keys" == "list-bg" ]]; then
  #   alpha="CC"  # ~80% opacity
  #   color_hex="#${color_value}${alpha}"
  # else

  if [[ "$dcol_var" == *_rgba ]]; then
  
    rgb_part=$(sed -E 's/rgba\(([0-9]+,[0-9]+,[0-9]+),.*/\1/' <<<"$color_value")

  # echo "sed -i -E \"s|^(\s*${target_key}:\s*rgba\()[0-9]+,[0-9]+,[0-9]+(,[0-9.]+\);)|\\1${rgb_part}\\2|\" \"$TARGET_FILE\""
    sed -i -E "s|(${target_key}:\s*rgba\().*(,)|\1${rgb_part}\2|" "$TARGET_FILE"
  else
    color_hex="#$color_value"
    # echo $color_hex
    # echo $target_key
    escaped_key=$(printf '%s\n' "$target_key" | sed -E 's/[][(){}.^$*+?|]/\\&/g')

    # Use sed to replace the value (assuming format: key: #XXXXXX;)
    sed -i -E "s|^(\s*${escaped_key}\s*=\s*['\"])#[0-9A-Fa-f]{6}(['\"])|\1${color_hex}\2|" "$TARGET_FILE"
  fi
done
