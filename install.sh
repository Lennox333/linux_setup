#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 packages.lst"
  exit 1
fi

PKGFILE="$1"

if [ ! -f "$PKGFILE" ]; then
  echo "File not found: $PKGFILE"
  exit 1
fi

if command -v dnf >/dev/null 2>&1; then
  PKG_MGR="dnf"
elif command -v pacman >/dev/null 2>&1; then
  PKG_MGR="pacman"
else
  echo "Neither dnf nor pacman found on this system."
  exit 1
fi

mapfile -t packages < <(grep -vE '^\s*($|#)' "$PKGFILE")

if [ ${#packages[@]} -eq 0 ]; then
  echo "No packages found in $PKGFILE"
  exit 1
fi

echo "Using package manager: $PKG_MGR"
echo "Packages to install: ${packages[*]}"

case "$PKG_MGR" in
dnf)
  sudo dnf install \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

  # Skip missing packages silently
  sudo dnf install -y --setopt=skip_missing_names_on_install=True "${packages[@]}"
  ;;
pacman)
  # Sync db once
  sudo pacman -Sy --noconfirm
  # Install packages one by one ignoring failures
  for pkg in "${packages[@]}"; do
    echo "Installing $pkg..."
    if ! sudo pacman -S --noconfirm --needed "$pkg"; then
      echo "Warning: Package $pkg not found or failed to install, skipping."
    fi
  done
  ;;
esac
