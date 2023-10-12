#!/bin/bash

# This script is meant to automate the process as much as possible to allow for DOD CAC readers to be used on the VALVE SteamDeck. Please see additional documentation for troubleshooting and resources.

# FireFox Howto: https://public.cyber.mil/pki-pke/end-users/getting-started/linux-firefox/
# Linux Howto: https://public.cyber.mil/pki-pke/end-users/getting-started/linux/

echo "Warning: This will enable read-write access. Only execute this script as needed. This will use sudo, force a reset of your password."

read -p "Does your CAC reader have a keypad? (Y/N): " cac_keypad

if [ "$cac_keypad" == "Y" ]; then
    echo "enable_pinpad=false" | sudo tee -a /etc/opensc.conf
fi

sudo passwd
sudo btrfs property set -ts / ro false
sudo pacman-key --populate archlinux
sudo pacman -S ccid
sudo pacman -S opensc
sudo systemctl enable pcscd.service
sudo systemctl start pcscd.service
sudo systemctl start pcscd.socket
sudo systemctl restart pcscd.socket

echo "Downloading certificates..."
wget -P /home/deck/downloads https://dl.dod.cyber.mil/wp-content/uploads/pki-pke/zip/unclass-certificates_pkcs7_v5-6_dod.zip
unzip /home/deck/downloads/unclass-certificates_pkcs7_v5-6_dod.zip

echo "Certificates have been downloaded, you must add them to Firefox."
echo "After adding certificates, add a module with the following .so: /lib64/pkcs11/opensc-pkcs11.so"
echo "When ready, connect the CAC reader."

read -p "Ready?(Y): " ready

if [ "$ready" == "Y" ]; then
    sudo pcsc_scan
fi
