#!/bin/bash
set -e # Stop on Error
set -v # Verbose

# Options
drive="/dev/nvme1n1"
boot_part="/dev/nvme1n1p1"
swap_part="/dev/nvme1n1p2"
root_part="/dev/nvme1n1p3"
mem_size=32
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
sudo parted $drive -s unit mib mkpart primary linux-swap 514 $((514 + ($mem_size * 1024)))
sudo mkswap $swap_part

### Root Partition
sudo parted $drive -s unit mib mkpart primary ext4 $((515 + ($mem_size * 1024))) 100%
sudo mkfs.ext4 $root_part

# Mount Partitions
sudo mount --mkdir $root_part $mount_point
sudo mount --mkdir $boot_part $mount_point/boot

# Install Base
sudo pacstrap $mount_point base linux linux-firmware

# Change Root
sudo cp ./install2.sh /mnt/install2.sh
sudo arch-chroot $mount_point