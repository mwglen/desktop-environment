#!/bin/bash
set -e # Stop on Error
set -v # Verbose

# Options
drive="/dev/nvme1n1"
boot_part="/dev/nvme1n1p1"
swap_part="/dev/nvme1n1p2"
root_part="/dev/nvme1n1p3"
mount_point="/mnt"

# Unmap Old Partitions
sudo umount $boot_part || true
sudo umount $root_part || true

# Setup Partitions
## Create GPT Table
sudo parted $drive -s mklabel gpt

## Create Partitions
### Boot Partition
sudo parted $drive -s unit mib mkpart primary fat32 1 513
sudo parted $drive -s set 1 esp on
sudo mkfs.fat -F 32 $boot_part

### Swap Partition
mem_size=$(( $(grep MemTotal /proc/meminfo | awk '{print $2}') / 1000 / 1000))
sudo parted $drive -s unit mib mkpart primary linux-swap 514 $((514 + ($mem_size * 1024)))
sudo mkswap $swap_part

### Root Partition
sudo parted $drive -s unit mib mkpart primary ext4 $((515 + ($mem_size * 1024))) 100%
sudo mkfs.ext4 $root_part

# Mount Partitions
sudo mount --mkdir $root_part $mount_point
sudo mount --mkdir $boot_part $mount_point/boot
sudo swapon $swap_part

# Install Base
sudo pacstrap $mount_point base linux linux-firmware

# Generate fstab
sudo genfstab -U $mount_point >> $mount_point/etc/fstab

# Change Root
sudo cp ./2_setup_user.sh $mount_point
sudo cp ./3_install_applications.sh $mount_point
sudo arch-chroot $mount_point ./2_setup_user.sh
