#!/bin/bash
set -e # Stop on Error
set -v # Verbose

# Options
time_zone="US/Eastern"
host_name="MattArch"
user="mwglen"

# Set Time Zone
ln -sf /usr/share/zoneinfo/$time_zone /etc/localtime
hwclock --systohc

# Localization
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo $host_name > /etc/hostname

# Initramfs
mkinitcpio -P

# Root Password
passwd

# New User
pacman --noconfirm -Sy zsh
useradd -m -s /bin/zsh $user
usermod -G wheel $user
echo '%wheel ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo
touch /home/$user/.zshrc
passwd $user

# Install Grub
pacman --noconfirm -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
sudo tee /etc/default/grub

EOF
grub-mkconfig -o /boot/grub/grub.cfg

# Switch to User
su $user