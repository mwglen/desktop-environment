#!/bin/bash

set -e

set -v

# NOTE: This file is generated from config.org

nvidia="true"
gmail="mwg2202@gmail.com"

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
git clone https://aur.archlinux.org/yay.git ~/$REPOSITORIES/yay
cd ~/$REPOSITORIES/yay && makepkg -si
rm -rf ~/$REPOSITORIES/yay

sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

sudo pacman --noconfirm --needed -S git python3 python-pip
pip3 install -r dotdrop/requirements.txt --user
sudo pip3 install -r dotdrop/requirements.txt

git clone https://github.com/mwglen/desktop-environment.git ~/Repositories/desktop-environment
cd ~/Repositories/desktop-environment

./dotdrop.sh install -p MattArch
sudo ./dotdrop.sh install -p MattArchSudo

sudo pacman --noconfirm -S grub efibootmgr
sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB_NEW
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo timedatectl set-timezone America/New_York

sudo pacman -Syyu --needed --noconfirm git base-devel \
    && git clone https://aur.archlinux.org/yay.git \
    && cd yay && yes | makepkg -si
rm -rf $REPOSITORIES/yay

packages="cat install-scripts/arch/packages.txt | awk -F '#' '{print $1}' | tr -d '\n'"
yay -Syyu --noconfirm --needed $packages

sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

mkdir -p "$XDG_CONFIG_HOME"/git
touch "$XDG_CONFIG_HOME"/git/config
git config --global user.name "Matt Glen"
git config --global user.email "mwg2202@yahoo.com"
git config --global init.defaultBranch master

# cd /usr/share/fonts/nerd-fonts-complete/TTF && sudo mkfontscale && mkfontdir
# sudo xset +fp /usr/share/fonts/nerd-fonts-complete/TTF
sudo fc-cache -fv

# Create font directory
mkdir -p ~/.local/share/fonts

# Copy font to directory
cp /usr/share/fonts/'Roboto Mono Nerd Font Complete Mono.ttf' ~/.local/share/fonts/roboto-mono-nerd-font-complete-mono.ttf

# Initialize font directory
cd ~/.local/share/fonts && mkfontscale && mkfontdir

# Add font directory
xset +fp '/home/$USER/.local/share/fonts'
xset fp rehash

rustup default nightly
rustup component add rls || true
rustup component add rust-analysis rust-src

pip install git+https://github.com/yuce/pyswip@master#egg=pyswip

sudo systemctl enable bluetooth

sudo systemctl enable NetworkManager

sudo systemctl enable tlp

#!/bin/bash
acpi -b | awk -F'[,:%]' '{print $2, $3}' | {
    read -r status capacity
  
    if [ "$status" = Discharging -a "$capacity" -lt 10 ]; then
        logger "Critical battery threshold"
        systemctl hibernate
    fi
}

sudo systemctl daemon-reload
sudo systemctl enable auto-hibernate.timer

sudo groupadd video
sudo usermod +aG video $USER
sudo chgrp video /sys/class/backlight/intel_backlight/brightness

cups sane python-pillow simple-scan

sudo systemctl enable cups

sudo npm install --global pure-prompt

mkdir ~/Mail/account.gmail
gmi init $gmail 
gmi pull

gem install date icalendar optparse tzinfo

git clone https://tero.hasu.is/repos/icalendar-to-org.git $REPOSITORIES/icalendar-to-org || true

curl https://raw.githubusercontent.com/unode/polypomo/master/polypomo > $XDG_CONFIG_HOME/polybar/scripts/polypomo
chmod +x $XDG_CONFIG_HOME/polybar/scripts/polypomo

sudo mkdir -p /etc/udev/rules.d
groupadd -r video && true
sudo usermod -a -G video $USER
sudo chgrp video /sys/class/backlight/intel_backlight/brightness
sudo chmod g+w /sys/class/backlight/intel_backlight/brightness

sudo systemctl enable lightdm

sudo locale-gen

# Members of the libvirt group have passwordless access to the RW daemon socket by default.
sudo usermod -a -G libvirt $USER
sudo usermod -a -G kvm $USER

sudo systemctl enable libvirtd # Also enables virtlogd and virtlockd

# Make sure to set user = /etc/libvirt/qemu.conf

curl -L https://raw.githubusercontent.com/thomas10-10/foo-Wallpaper-Feh-Gif/master/install.sh | bash
#back4.sh 0.010 gif/pixel.gif &

sudo pip3 install wpgtk

sudo pywalfox install

sudo npm install moby --global
