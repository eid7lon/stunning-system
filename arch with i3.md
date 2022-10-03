**Keyboard layout:**
```
loadkeys uk
```

**Connect to WiFi:**
```
iwctl
device list
station [device] get-networks
station [device] connect 'SSID'
```

**Test connectivity:**
```
ping -c 3 archlinux.org
```

**Ensure system clock:**
```
timedatectl set-ntp true
```

**Update mirrorlist:**
```
reflector -c United Kingdom -a 6 --sort rate --save /etc/pacman.d/mirrorlist
```

**Resync servers**
```
pacman -Syy
```

**Partition for efi with 512M, swap with 16G:**
EFI:
```
fdisk -l
fdisk /dev/sda
g
n
[default partition number 1]
[default first sector]
+512M
t
1
```
Swap:
```
n
[default partition number 2]
[default first sector]
+16G
t
[default partition number 2]
19
```
System:
```
n
[default partition number 3]
[default first sector]
[default last sector]
w
```

**Check partitions:**
```
fdisk -l /dev/sda
```

**Format partitions:**
```
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3
```

**Mount the file systems:**
```
mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot
```

**Install base packages plus neovim and microcode:**

```
pacstrap /mnt base base-devel linux linux-firmware neovim amd-ucode
```

**Create fstab file:**
```
genfstab -U /mnt >> /mnt/etc/fstab
```

**Verify fstab entries:**
```
cat /mnt/etc/fstab
```

**Root into the new system:**
```
arch-chroot /mnt
```

**Set the time zone:**
```
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
```

**Generate /etc/adjtime:**
```
hwclock --systohc
```

**Uncomment desired localization (example: #en_UK.UTF-8 UTF-8):**
```
nvim /etc/locale.gen
```

**Generate locale file:**
```
locale-gen
```

**Add content to locale file:**
```
nvim /etc/locale.conf
```

Add these lines:
```
   LANG=en_GB.UTF-8
```

**Update keyboard layout:**
```
nvim /etc/vconsole.conf
```

Add this line:
```
KEYMAP=uk
```

**Create the hostname file with desired [hostname]:**
```
echo [hostname] > /etc/hostname
```


**Update hosts file:**
```
nvim /etc/hosts
127.0.0.1 localhost
::1       localhost
127.0.1.1	[hostname].localdomain  [hostname]
```

**Set password for root:**
```
passwd
```

**Install base packages:**
```
pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant xdg-utils xdg-user-dirs git reflector tlp bluez bluez-utils alsa-utils pulseaudio pulseaudio-bluetooth
```

**Setup Grub bootloader:**
```
mkdir /boot/efi
mount /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg
```

**Enable NetworkManager, Bluetooth, TLP and TRIM**
```
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable tlp
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.service
systemctl enable fstrim.timer
```

**Add user with desired [username] and set password:**
```
useradd -m -G wheel [username]
passwd [username]
```

**Grant access to the user:**
```
EDITOR=nvim visudo
```
Uncomment for no password:
```
%wheel ALL=(ALL) NOPASSWD: ALL
```
Uncomment for password:
```
%wheel ALL=(ALL) ALL
```

**Exit and unmount:**
```
exit
umount -R /mnt
reboot
```

**Update time**
```
timedatectl set-ntp true
```

**Update hardware clock:**
```
sudo hwclock --systohc
```

**Update mirrorlist:**
```
reflector -c United Kingdom -a 6 --sort rate --save /etc/pacman.d/mirrorlist
```

**Enable reflector timer:**
```
sudo systemctl enable --now reflector.timer
```

**Install i3-gaps and LightDM:**
```
sudo pacman -S xorg i3-gaps dmenu lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings materia-gtk-theme papirus-icon-theme nitrogen firefox picom kitty ranger  
```

**Enable LightDM:**
```
sudo systemctl enable lightdm
```

**Set keyboard for the terminal:**
```
setxkbmap uk(or gb)
```

**Set keymap and nitrogen on launch:**
```
nvim .config/i3/config
```
Add lines to the end of the file:
```
#Keyboard
exec setxkbmap uk(or gb) &

#Nitroged
exec nitrogen --restore

#Picom
exec picom -f
```

**Enable theme for lightDM greeter:**
```
sudo lightdm-gtk-greeter-settings
```

