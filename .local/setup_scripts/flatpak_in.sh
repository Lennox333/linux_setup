#!/usr/bin/env bash

set -e

echo "Adding Flathub repository..."
flatpak remote-add --if-not-exists flathub \
  https://flathub.org/repo/flathub.flatpakrepo

echo "Installing Flatpak applications..."

flatpak install flathub com.github.Matoking.protontricks -y
flatpak install flathub com.github.tchx84.Flatseal -y
flatpak install flathub com.google.Chrome -y
flatpak install flathub com.obsproject.Studio -y
flatpak install flathub com.usebottles.bottles -y
flatpak install flathub dev.vencord.Vesktop -y
flatpak install flathub io.github.radiolamp.mangojuice -y
flatpak install flathub it.mijorus.gearlever -y
flatpak install flathub org.kde.krita -y
flatpak install flathub org.shotcut.Shotcut -y

echo "Installing MangoHud and Gamescope Vulkan layers..."

flatpak install flathub org.freedesktop.Platform.VulkanLayer.MangoHud -y
flatpak install flathub org.freedesktop.Platform.VulkanLayer.gamescope -y

echo "Applying Flatpak overrides for Bottles..."

flatpak override --user com.usebottles.bottles \
  --filesystem=xdg-run/gvfsd \
  --filesystem=xdg-data/applications \
  --filesystem=$HOME/.config/MangoHud \
  --filesystem=$HOME/Apps/Games

echo "Applying Flatpak overrides for Mango Juice..."

flatpak override --user io.github.radiolamp.mangojuice \
  --filesystem=$HOME/.config/MangoHud/MangoHud.conf

echo "Done."
