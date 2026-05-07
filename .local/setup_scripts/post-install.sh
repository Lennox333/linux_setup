#!/bin/bash
# Enable sddm service
sudo systemctl enable sddm.service

# Start sddm service immediately
sudo systemctl start sddm.service

echo "SDDM enabled and started."

echo "env QT_QPA_PLATFORM=xcb pentablet.desktop if you wanna run it"

# add menuentry 'Windows Boot Manager (on /dev/sdb1)' --class windows --class os $menuentry_id_option 'osprober-efi-D2C7-C25F' {
#   savedefault
#	insmod part_gpt
#	insmod fat
#	set root='hd1,gpt1' if grub doesnt save last boot option

#SUBSYSTEMS=="usb", ATTRS{idVendor}=="fffe", ATTRS{idProduct}=="0009", TAG+="uaccess"
#SUBSYSTEM=="hidraw", ATTRS{idVendor}=="fffe", ATTRS{idProduct}=="0009", TAG+="uaccess"

xdg-mime default thunar.desktop inode/directory

sed -i \
  -e 's|^TryExec=.*|TryExec=launch_nvim.sh|' \
  -e 's|^Exec=.*|Exec=launch_nvim.sh %F|' \
  ~/.local/share/applications/nvim.desktop

cat >~/.local/bin/xdg-terminal-exec <<'EOF'
#!/bin/sh
exec kitty "$@"
EOF

chmod +x ~/.local/bin/xdg-terminal-exec

sudo timedatectl set-local-rtc 1
