Keyboard layout list:

`localectl list-keymaps` 

Load keymap:

`loadkeys uk`

To verify the boot mode:

`ls /sys/firmware/efi/efivars`

Connect to WiFi:

`iwctl`

`device list`

`station [device] get-networks`

`station [device] connect 'SSID'`

Test connectivity:

`ping -c 3 archlinux.org`

Update mirrorlist:

`pacman -Sy`

`pacman -S reflector`

`reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist`

Ensure system clock:

`timedatectl set-ntp true`

`timedatectl status`

Correct system clock:

`timedatectl list-timezone`

`timedatectl set-timezone Europe/London`

Partition for efi with 512M, swap with 16G:

`fdisk -l`

`fdisk /dev/sda`

`g`

`n`

`[default partition number 1]`

`[default first sector]`

`+512M`

`t`

`1`

-

`n`

`[default partition number 2]`

`[default first sector]`

`+16G`

`t`

`[default partition number 2]`

`19`

-

`n`

`[default partition number 3]`

`[default first sector]`

`[default last sector]`

`w`

-

Check partition:

`fdisk -l /dev/sda`

Format partitions:


`mkfs.fat -F 32 /dev/sda1`

`mkfs.ext4 /dev/sda3`

`mkswap /dev/sda2`

`swapon /dev/sda2`


Mount the file systems:

`mount /dev/sda3 /mnt`

`mount --mkdir /dev/sda1 /mnt/boot`

Install base system with sudo, nano, alacritty:

`pacstrap /mnt base base-devel openssh linux linux-firmware sudo nano alacritty`

Create fstab file:

`genfstab -U /mnt >> /mnt/etc/fstab`

Verify fstab entries:

`cat /mnt/etc/fstab`

Change root into the new system:

`arch-chroot /mnt`

Set the time zone:

`ls /usr/share/zoneinfo`

`ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime`

Generate /etc/adjtime:

`hwclock --systohc`

Uncomment desired localization (example: #en_UK.UTF-8 UTF-8):

`nano /etc/locale.gen`

Generate locales:

`locale-gen`

Create locale.conf and set LANG varialbe (example: en_UK.UTF-8):

`echo LANG=en_UK.UTF-8 > /etc/locale.conf`

Update keyboard layout:

`echo KEYMAP=uk > /etc/vconsole.conf`

Create the hostname file:

`echo [HOSTNAME] > /etc/hostname`

Set password:

`passwd`

Add content to the hosts file

`nano /etc/hosts`

`127.0.0.1    localhost.localdomain   localhost`

`::1          localhost.localdomain   localhost`

`127.0.0.1    thinkpad.localdomain    arch`


Enable SSH, NetworkManager, and DHCP

`pacman -S dhcpcd networkmanager network-manager-applet`

`systemctl enable sshd`

`systemctl enable dhcpcd`

`systemctl enable NetworkManager`

Install necessary packages:

`pacman -S iw dialog git reflector lshw htop`

`pacman -S wget pulseaudio alsa-utils alsa-plugins pavucontrol`

Install Grub boot loader:

`pacman -S grub efibootmgr`

`mkdir /boot/efi`

`mount /dev/sda1 /boot/efi`

`grub-install --target=x86_64-efi --bootloader-id=grub_uefi`

`grub-mkconfig -o /boot/grub/grub.cfg`

Add username, set password and give permissions:

`useradd -m -G wheel [username]`

`passwd [username]`

Remove uncomment first "%wheel ALL=(ALL) ALL" under "Uncomment to allow members of group wheel to execute any command" by removing "#":

`EDITOR=nano visudo`
 
Exit and unmount:

`exit`

`umount -R /mnt`

`reboot`

Post-install:

Yay:

`mkdir Sources`

`cd Sources`

`git clone https://aur.archlinux.org/yay.git`

`cd yay`

`makepkg -si`

Setup Bluetooth:

`sudo pacman -S bluez bluez-utils blueman`

`sudo systemctl enable bluetooth`

Battery:

`sudo pacman -S tlp tlp-rdw powertop acpi`

`sudo systemctl enable tlp`

`sudo systemctl enable tlp-sleep`

`sudo systemctl mask systemd-rfkill.service`

`sudo systemctl mask systemd-rfkill.service`

`sudo pacman -S acpi_call`

SSD TRIM:

`sudo systemctl enable fstrim.timer`

i3:

`sudo pacman -S xorg-server xorg-apps xorg-xinit`

`sudo -S i3-gaps i3blocks i3lock`

Fonts:

`sudo pacman -S noto-fonts ttf-ubuntu-font-family ttf-dejavu ttf-freefont`

`sudo pacman -S ttf-liberation ttf-droid ttf-roboto terminus-font`

Tools:

`sudo pacman -S rxvt-unicode ranger rofi dmenu --needed`


