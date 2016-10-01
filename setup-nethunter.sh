#!/bin/bash
# setup-nethunter, version 1.00

ROOT_UID = 0 # $UID = 0 is usually root.
E_NOTROOT = 87 # Non-root exit error.

# Run as root
if [ "$UID" -ne "$ROOT_UID" ]
	then
	echo "You're not running this script root previliges."
	echo "Do sudo ./setup-nethunter.sh or su && ./setup-nethunter.sh"
	exit $E_NOTROOT

# Install basic utilites
apt-get install gcc libpcap-dev aircrack-ng sqlite3 libsqlite3-dev libssl-dev bully wifite make

# Get my own bash scripts
cd ~
mkdir bash-scripts
cd bash-scripts
git init
git remote add origin https://github.com/daedroza/bash-scripts.git
git pull origin master

# Setup additional tools
cd ~
mkdir make
cd make
git clone https://github.com/t6x/reaver-wps-fork-t6x.git
git clone https://github.com/binkybear/wifite-mod-pixiewps.git
cd reaver-wps-fork-t6x/src/
./configure
make && make install
cp /root/make/wifite-mod-pixiewps/wifite-ng /usr/bin/wifite-ng
chmod +x /usr/bin/wifite-ng
cd ~
rm -rf make


