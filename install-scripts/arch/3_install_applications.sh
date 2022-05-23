#!/bin/bash
set -e # Stop on Error
set -v # Verbose

nvidia="true"
gmail="mwg2202@gmail.com"
timezone="America/New_York"

XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
XDG_STATE_HOME="$HOME/.local/state"
REPOSITORIES="$HOME/Repositories"
MAIL="$HOME/Mail"

mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_CACHE_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_STATE_HOME
mkdir -p $REPOSITORIES
mkdir -p $MAIL

sudo pacman --noconfirm -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git $REPOSITORIES/yay
cd $REPOSITORIES/yay && makepkg -si
rm -rf $REPOSITORIES/yay
cd $REPOSITORIES

sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

# Install Packages that need to be installed before Config
yay --noconfirm --needed -S nsxiv

# Get Dependencies
yay --noconfirm --needed -S git dotdrop

# Install Configuration
git clone https://github.com/mwglen/desktop-environment.git $REPOSITORIES/desktop-environment
cd $REPOSITORIES/desktop-environment \
    && dotdrop install -p MattArch \
    && sudo dotdrop install -p MattArchSudo

sudo pacman --noconfirm -S grub efibootmgr
sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB_NEW
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo timedatectl set-timezone $timezone

packages="$(cat $REPOSITORIES/desktop-environment/install-scripts/arch/packages.txt | awk -F '#' '{print $1}' | tr -s '\n' ' ')"
yay -Syyu --needed $packages

mkdir -p "$XDG_CONFIG_HOME"/git
touch "$XDG_CONFIG_HOME"/git/config
git config --global user.name "Matt Glen"
git config --global user.email "mwg2202@yahoo.com"
git config --global init.defaultBranch master

# cd /usr/share/fonts/nerd-fonts-complete/TTF && sudo mkfontscale && mkfontdir
# sudo xset +fp /usr/share/fonts/nerd-fonts-complete/TTF
sudo fc-cache -fv

rustup default nightly
rustup component add rls || true
rustup component add rust-analysis rust-src

sudo systemctl enable bluetooth

sudo systemctl enable NetworkManager

sudo systemctl enable tlp

sudo systemctl daemon-reload
sudo systemctl enable auto-hibernate.timer

sudo groupadd video || true
sudo usermod -a -G video $USER
#sudo chgrp video /sys/class/backlight/intel_backlight/brightness
#sudo chmod g+w /sys/class/backlight/intel_backlight/brightness

sudo systemctl enable cups
sudo systemctl enable avahi-daemon

mkdir -p $MAIL/account.gmail
#gmi init $gmail 
#gmi pull

gem install date icalendar optparse tzinfo

git clone https://tero.hasu.is/repos/icalendar-to-org.git $REPOSITORIES/icalendar-to-org || true

curl https://raw.githubusercontent.com/unode/polypomo/master/polypomo > $XDG_CONFIG_HOME/polybar/scripts/polypomo
chmod +x $XDG_CONFIG_HOME/polybar/scripts/polypomo

sudo systemctl enable lightdm

sudo locale-gen

# Members of the libvirt group have passwordless access to the RW daemon socket by default.
sudo usermod -a -G libvirt $USER
sudo usermod -a -G kvm $USER

sudo systemctl enable libvirtd # Also enables virtlogd and virtlockd

# Make sure to set user = /etc/libvirt/qemu.conf

yay -S --noconfirm --needed anki || true
yay -S --noconfirm --needed anki || true

curl -L https://raw.githubusercontent.com/thomas10-10/foo-Wallpaper-Feh-Gif/master/install.sh | bash
#back4.sh 0.010 gif/pixel.gif &

sudo pywalfox install

sudo npm install moby --global
