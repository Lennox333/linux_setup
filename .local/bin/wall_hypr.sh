target_file=~/.config/hypr/themes/colors.conf                        # Your config file (target)

# Load variables from dcol file
source "$1"
# Find all variables ending with _rgba
rgba_vars=($(compgen -v | grep '_rgba$'))
# echo "${rgba_vars[@]}"

for varname in "${rgba_vars[@]}"; do
    value="${!varname}" # Get variable value, e.g. rgba(46,0,9,0.95)
    rgb_part=$(sed -E 's/rgba\(([0-9]+,[0-9]+,[0-9]+),.*/\1/' <<<"$value")
    key_suffix="${varname#dcol_}"
    target_key="wallbash_${key_suffix}"

    # Replace line in target file matching config_key, replacing entire rgba(...) part
    sed -i -E "s|(${target_key}[[:space:]]*=[[:space:]]*rgba\()[0-9]+,[0-9]+,[0-9]+|\1${rgb_part}|" "$target_file"
done
