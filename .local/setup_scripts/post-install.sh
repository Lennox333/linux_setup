#!/bin/bash
# Enable sddm service
sudo systemctl enable sddm.service

# Start sddm service immediately
sudo systemctl start sddm.service

echo "SDDM enabled and started."



echo "env QT_QPA_PLATFORM=xcb pentablet.desktop if you wanna run it"

#SUBSYSTEMS=="usb", ATTRS{idVendor}=="fffe", ATTRS{idProduct}=="0009", TAG+="uaccess"
#SUBSYSTEM=="hidraw", ATTRS{idVendor}=="fffe", ATTRS{idProduct}=="0009", TAG+="uaccess"