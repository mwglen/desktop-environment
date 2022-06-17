# Desktop Environment

## Screenshots

![2022-06-17_13-12-fs8](https://user-images.githubusercontent.com/10079472/174346685-3a3ed8cd-95c3-4627-800c-318c02723bea.png)

![2022-06-17_13-04](https://user-images.githubusercontent.com/10079472/174345477-95888473-0c28-4637-b064-be9cfe990430.png)

## To Install:
1. Change the options for the scripts located in the `install-scripts` directory
2. Run `1_setup_partitions.sh` from inside the `install_scripts` directory (Note: This will delete all data on the specified partition)
3. Enter sudo password whenever prompted
4. Restart the system

## Important Information:
- Consider enabling SSD Trim by running `sudo systemctl enable fstrim.timer`. This prevents write amplification and can lead to faster drives that live longer. Make sure to check `lsblk --discard` for non-zero values of `DISC-GRAN` and `DISC_MAX` before enabling. This starts up a weekly timer to trim your drive
- After installing, make sure to run `bw login` so that bitwarden can be used in other applications such as bitwarden-rofi
- If you reach a "unknown trust" error from pacman. Try running `pacman-key --refresh-keys`
- If you reach a "corrupted GPG key" error from pacman. Try running `pacman -Sy archlinux-keyring`
- If you reach a "unable to lock database" error when the script runs pacman, run `sudo rm /var/lib/pacman/db.lck` and try the script again. This usually happens after force closing the script while it is running.
- To Setup Samba:
  - Setup a samba username and password by running `sudo smbpasswd -a <username>` and then entering your password
  - Edit the config for samba in setup.org to share your directory and then retangle setup.org
  - Enable the samba daemon by running `sudo systemctl enable --now samba`.
  - To connect to shared folder on a windows machine create a shorcut to `\\IP-ADDRESS\SHARE-NAME`
