#!/usr/bin/env bash

set -e

DATE="$(date +%Y-%m-%d_%H-%M-%S)"
BACKUP_BASE="$HOME/.local/setup_scripts/assets"
TEMP_DIR="$BACKUP_BASE/krita-flatpak-$DATE"
ARCHIVE="$BACKUP_BASE/krita-flatpak-$DATE.tar.gz"

mkdir -p "$TEMP_DIR/config"
mkdir -p "$TEMP_DIR/data"

echo "Backing up Krita Flatpak configuration..."

cp -v "$HOME/.var/app/org.kde.krita/config/kritadisplayrc" \
  "$TEMP_DIR/config/" || true

cp -v "$HOME/.var/app/org.kde.krita/config/kritarc" \
  "$TEMP_DIR/config/" || true

cp -v "$HOME/.var/app/org.kde.krita/config/kritashortcutsrc" \
  "$TEMP_DIR/config/" || true

echo "Backing up Krita data directory..."

cp -av "$HOME/.var/app/org.kde.krita/data/krita" \
  "$TEMP_DIR/data/" || true

echo "Creating compressed archive..."

tar -czvf "$ARCHIVE" -C "$BACKUP_BASE" \
  "krita-flatpak-$DATE"

echo "Cleaning temporary files..."

rm -rf "$TEMP_DIR"

echo
echo "Backup completed:"
echo "$ARCHIVE"
