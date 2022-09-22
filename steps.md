[find](https://wiki.archlinux.org/title/Linux_console/Keyboard_configuration) keymap

`localectl list-keymaps` 



ls /sys/firmware/efi/efivars

Connect to WiFi:

`iwctl
device list
station 'device' get-networks
station 'device' connect 'SSID'`

ping -c 3 archlinux.org

timedatectl set-ntp true
timedatectl status

fdisk -l
cfdisk /dev/sda

mkfs.fat -F 32 /dev/efi_system_partition
mkswap /dev/swap_partition
mkfs.ext4 /dev/root_partition

mount /dev/root_partition
mount --mkdir /dev/efi_system_partition /mnt/boot
swapon /dev/swap_partition

pacman -Syy
pacstrap /mnt base linux linux-firmware sudo nano alacritty

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime

hwclock --systohc

nano /etc/locale.gen
locale-gen

echo LANG=en_UK.UTF-8 > /etc/locale.conf
export LANG=en_UK.UTF-8

echo 'arch' > /etc/hostname

nano /etc/hosts
127.0.0.1	localhost
::1		localhost
127.0.1.1	arch

passwd (set password)

pacman -S grub efibootmgr os-prober mtools

mkdir /boot/efi
mount /dev/efi_system_partition

grub-install --target=x86_64-efi --bootloader-id=grub_efi
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo

pacman -S xorg plasma-meta
systemctl enable sddm.service
systemctl enable NetworkManager.service

useradd -m -G wheel 'username'

EDITOR=nano visudo

remove # from first %wheel ALL=(ALL) ALL

exit
umount -R /mnt
reboot

sudo pacman -Syy
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
sudo makepkg -si
rm -rf yay
