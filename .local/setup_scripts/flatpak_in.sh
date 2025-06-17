flatpak install flathub com.usebottles.bottles -y
flatpak install flathub io.github.radiolamp.mangojuice -y

flatpak override --user com.usebottles.bottles \
  --filesystem=xdg-run/gvfsd \
  --filesystem=xdg-data/applications \
  --filesystem=~/.config/MangoHud \
  --filesystem=~/Apps/Games

flatpak install org.freedesktop.Platform.VulkanLayer.MangoHud
flatpak install org.freedesktop.Platform.VulkanLayer.gamescope

flatpak override --user io.github.radiolamp.mangojuice --filesystem=~/.config/MangoHud/MangoHud.conf
