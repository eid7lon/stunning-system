[Find](https://wiki.archlinux.org/title/Linux_console/Keyboard_configuration) keymap:

`localectl list-keymaps` 

Load keymap:

`loadkeys [keymap]`

To verify the boot mode, list the [efivars](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface#UEFI_variables) directory:

`ls /sys/firmware/efi/efivars`

Connect to WiFi:

`iwctl`

`device list`

`station [device] get-networks`

`station [device] connect 'SSID'`

Test connectivity:

`ping -c 3 archlinux.org`

Ensure system clock:

`timedatectl set-ntp true`

`timedatectl status`

Correct system clock:

`timedatectl list-timezone`

`timedatectl set-timezone [TIMEZONE]`

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

`pacstrap /mnt base linux linux-firmware sudo nano alacritty`

Create fstab file:

`genfstab -U /mnt >> /mnt/etc/fstab`

Verify fstab entries:

`cat /mnt/etc/fstab`

Change root into the new system:

`arch-chroot /mnt`

Set the time zone:

`ls /usr/share/zoneinfo`

`ls /usr/share/zoneinfo/[REGION]`

`ln -sf /usr/share/zoneinfo/[REGION]/[CITY] /etc/localtime`

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


Install Grub boot loader:

`pacman -S grub efibootmgr`

`mkdir /boot/efi`

`mount /dev/sda1 /boot/efi`

`grub-install --target=x86_64-efi --bootloader-id=grub_uefi`

`grub-mkconfig -o /boot/grub/grub.cfg`

Install Plasma-meta:

`pacman -S xorg plasma-meta`


`systemctl enable sddm.service`

`systemctl enable NetworkManager.service`

Enable breeze login screen by adding "Current=breeze" under [Theme] > # Current theme name

`sudo nano /usr/lib/sddm/sddm.conf.d/default.conf`

Add username, set password and give permissions:

`useradd -m -G wheel [username]`

`passwd [username]`

Remove uncomment first "%wheel ALL=(ALL) ALL" under "Uncomment to allow members of group wheel to execute any command" by removing "#":

`EDITOR=nano visudo`
 
Exit and unmount:

`exit`

`umount -R /mnt`

`reboot`

sudo pacman -Syy
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
sudo makepkg -si

rm -rf yay
