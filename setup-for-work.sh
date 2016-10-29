#!/bin/bash
# setup-for-work

# Automate a way to reduce pain.

ROOT_UID=0 # $UID = 0 is usually root.
E_NOTROOT=87 # Non-root exit error.

# Run as root
if [ "$UID" -ne "$ROOT_UID" ]
	then
	echo "You're not running this script with root previliges."
	echo "Type su and enter your root password first, and then run this script."
	exit $E_NOTROOT
fi

# Do a safe update/upgrade after fresh install[1]
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
echo "[1/3] done."
sleep 4

# Some android-stuff[2]
sudo apt-get -y purge openjdk-\* icedtea-\* icedtea6-\*
sudo apt-get update
sudo apt-get -y install openjdk-8-jdk
sudo apt-get -y install liblz4-tool git-core gnupg ccache lzop flex bison gperf build-essential zip curl zlib1g-dev zlib1g-dev:i386 libc6-dev lib32ncurses5 lib32z1 lib32ncurses5-dev x11proto-core-dev libx11-dev:i386 libreadline6-dev:i386 lib32z-dev libgl1-mesa-glx:i386 libgl1-mesa-dev g++-multilib tofrodos python-markdown libxml2-utils xsltproc readline-common libreadline6-dev libreadline6 libncurses5-dev lib32readline6 libreadline-dev libreadline6-dev:i386 libreadline6:i386 bzip2 libbz2-dev libbz2-1.0 libghc-bzlib-dev libsdl1.2-dev libesd0-dev squashfs-tools pngcrush schedtool python maven liblz4-tool adb fastboot bc

# Install nvidia-drivers, VB[3]
sudo apt-get -f -y install
sudo apt-get -y install linux-headers-$(uname -r)
sudo apt-get -y install virtualbox vlc nvidia-kernel-dkms
sed 's/quiet/quiet nouveau.modeset=0/g' -i /etc/default/grub
update-grub
echo "[3/3] done."
echo "Rebooting will start in 20 seconds"
sleep 20
reboot
