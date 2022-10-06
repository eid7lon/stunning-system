**Keyboard layout:**
```
loadkeys uk
```

**To verify the boot mode:**
```
ls /sys/firmware/efi/efivars
```

setfont ter-132n

**Connect to WiFi:**
```
iwctl
device list
station [device] scan
station [device] get-networks
station [device] connect 'SSID'
```

**Test connectivity:**
```
ping -c 3 archlinux.org
```

**Update mirrorlist:**
```
pacman -Sy
pacman -S reflector
reflector -c United Kingdom -a 6 --sort rate --save /etc/pacman.d/mirrorlist
```

**Ensure system clock:**
```
timedatectl set-ntp true
timedatectl set-timezone Europe/London
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
mkfs.fat -F 32 /dev/sda1
mkfs.ext4 /dev/sda3
mkswap /dev/sda2
swapon /dev/sda2
```

**Mount the file systems:**
```
mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot
```

**Install base packages plus kitty and neovim:**

```
pacstrap /mnt base base-devel linux linux-firmware neovim kitty tlp reflector
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

**Set password for root:**
```
passwd
```

**Update hosts file:**
```
nvim /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   [hostname].localdomain  [hostname]

```

**Add user with desired [username], set password and give permissions:**
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

**Install Grub bootloader:**
```
pacman -S grub efibootmgr
mkdir /boot/efi
mount /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=grub_uefi
grub-mkconfig -o /boot/grub/grub.cfg
```

**Install Plasma-meta:**
```
pacman -S xorg plasma-meta
systemctl enable sddm
systemctl enable NetworkManager
systemctl enable tlp
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.service
systemctl enable fstrim.timer
```

**Enable breeze login screen:**
```
nvim /usr/lib/sddm/sddm.conf.d/default.conf
```
Add to  [Theme] > # Current theme name:
```
"Current=breeze"
```

**Exit and unmount:**
```
exit
umount -R /mnt
reboot
```

**Update mirrorlist:**
```
reflector -c United Kingdom -a 6 --sort rate --save /etc/pacman.d/mirrorlist
```

**Install Yay:**
```
sudo pacman -Syy
sudo pacman -S git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
```
