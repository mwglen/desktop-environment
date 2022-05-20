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
pacman --noconfirm -Sy zsh sudo
useradd -m -s /bin/zsh $user
usermod -G wheel $user
echo '%wheel ALL=(ALL:ALL) ALL' | EDITOR='tee -a' visudo
touch /home/$user/.zshrc
passwd $user

# Switch to User
rm '/2_setup_user.sh'
sudo -i -u $user -H zsh -c '/3_install_applications.sh'
