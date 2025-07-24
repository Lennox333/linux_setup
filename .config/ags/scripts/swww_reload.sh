# WALL_PATH=$1
# OUTPUT_DIR=$2

WALL_PATH=/home/ln607/Wallpapers/
OUTPUT_DIR=/home/ln607/Wallpapers/test/

if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi

find $WALL_PATH -path /home/ln607/Wallpapers/Wall-Dcol -prune -o -type f -print | while IFS= read -r file; do
    filename=$(basename ${file})
    ext="${filename##*.}"
    filename="${filename%.*}"
    path_to_save="$OUTPUT_DIR${filename}.thumb"
    # echo "$file"
    magick "$file" -resize 640x360 "$path_to_save"

done
