#!/usr/bin/env bash

set -e

BACKUP_DIR="$HOME/.local/setup_scripts/assets"
DATE="$(date +%Y-%m-%d_%H-%M-%S)"

OUTPUT_FILE="$BACKUP_DIR/wallpapers-backup-$DATE.tar.gz"
SOURCE_DIR="$HOME/Wallpapers"

mkdir -p "$BACKUP_DIR"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source directory not found: $SOURCE_DIR"
  exit 1
fi

echo "Creating backup of Wallpapers..."

tar -czvf "$OUTPUT_FILE" -C "$HOME" Wallpapers

echo "Backup created:"
echo "$OUTPUT_FILE"
