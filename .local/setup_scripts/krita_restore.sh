#!/usr/bin/env bash

set -e

ARCHIVE="$1"
RESTORE_DIR="$(mktemp -d)"

if [[ -z "$ARCHIVE" ]]; then
  echo "Usage: $0 <backup.tar.gz>"
  exit 1
fi

echo "Extracting archive..."

tar -xzvf "$ARCHIVE" -C "$RESTORE_DIR"

BACKUP_FOLDER="$(find "$RESTORE_DIR" -maxdepth 1 -type d -name 'krita-flatpak-*' | head -n1)"

if [[ -z "$BACKUP_FOLDER" ]]; then
  echo "Backup folder not found."
  exit 1
fi

echo "Restoring Krita configuration..."

mkdir -p "$HOME/.var/app/org.kde.krita/config"
mkdir -p "$HOME/.var/app/org.kde.krita/data"

cp -av "$BACKUP_FOLDER/config/." \
  "$HOME/.var/app/org.kde.krita/config/" || true

cp -av "$BACKUP_FOLDER/data/krita" \
  "$HOME/.var/app/org.kde.krita/data/" || true

echo "Cleaning temporary files..."

rm -rf "$RESTORE_DIR"

echo
echo "Restore completed."
