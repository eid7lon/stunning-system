#!/usr/bin/env bash
echo
echo "Starting the installation"
echo

PKGS=(
	'amd-ucode'
        'tlp'
	'wget'
	#Bluetooth
	'bluez'
	'bluez-utils'
	#Audio
	'alsa-utils'
	'alsa-plugins'
	'pulseaudio'
	'pulseaudio-alsa'
	'pulseaudio-bluetooth'
)
for PKG in "${PKGS[@]}"; do
    echo "Installing ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

sudo systemctl enable tlp #Enable laptop power managements
sudo systemctl mask systemd-rfkill.service #Resolve TLP conflicts
sudo systemctl mask systemd-rfkill.service #Resolve TLP conflicts
sudo systemctl enable fstrim.timer #Enable SSD trimmer


echo
echo "Done!"
echo
