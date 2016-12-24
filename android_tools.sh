# A very small and simple script to help me.

#!/bin/bash

CM_DRIVE='/media/daedroza/workspace/CyanogenMod-14.X';

# Standard Stuff
standard() {
  cd ${CM_DRIVE};
}

ccache() {
  export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4096m";
  ./prebuilts/sdk/tools/jack-admin kill-server; # My 8 gigs of RAM :(
  ./prebuilts/sdk/tools/jack-admin start-server; # Need more memory
  export USE_CCACHE=1;
  export USE_PREBUILT_CACHE=1;
  export CCACHE_DIR=~/.ccache;
  export CCACHE_LOGFILE=${CCACHE_DIR}/ccache.log;
}

initialise() {
  device_name='';
  echo "You're building for which device?"
  read device_name;
  source build/envsetup.sh;
  breakfast ${device_name};
}

# Make a build
build_rom() {
  standard;
  initialise;
  ccache;
  export OUT_DIR=/media/daedroza/output/out
  make bacon -j8;
  exit 0;
}

# Make a kernel
build_kernel() {
  cd $CM_DRIVE;
  initialise;
  export OUT_DIR=/media/daedroza/output/out_kernel;
  make bootimage -j16;
  exit 0;
}

# MENU
menu() {
	clear
	echo "MENU :";
	echo "1. ROM";
	echo "2. Kernel";
	echo "3. Exit";
}

# INPUT
input() {
  choice='';
  echo "Enter choice [1-3]:"
	read choice;
	case $choice in
		1) build_rom ;;
		2) build_kernel ;;
    3) exit 0 ;;
	esac
}

# MAIN
while true
do
	menu;
	input;
done
