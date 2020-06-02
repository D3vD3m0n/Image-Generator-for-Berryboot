#!/bin/bash

# LibreELEC Stable Build Image Generator for Berryboot
# Copyright 2018-2019 Alexander G.
# http://www.alexgoldcheidt.com
# https://github.com/agoldcheidt

if [ "$EUID" -ne 0 ]
then 
    echo 1>&2 "Please run as root"
    exit 1
fi

#date
date=$(date +"%d-%b-%Y")
#show version 
LATEST=$( wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/stable.i" )
clear

#Some arwork...
echo "  _    _ _            ___ _    ___ ___   ___ _        _    _     ";
echo " | |  (_| |__ _ _ ___| __| |  | __/ __| / __| |_ __ _| |__| |___ ";
echo " | |__| | '_ | '_/ -_| _|| |__| _| (__  \__ |  _/ _\` | '_ | / -_)";
echo " |____|_|_.__|_| \___|___|____|___\___| |___/\__\__,_|_.__|_\___|";
echo "                                                                 ";

echo ""
echo "#### LibreELEC STABLE IMAGE GENERATOR FOR BERRYBOOT ####"
echo ""

#LibreELEC Stable Image Menu Selection
PS3='Please select your device: '
options=("Raspberry Pi 1/Zero" "Raspberry Pi 2/3" "All Raspberry Pi Devices" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Raspberry Pi 1/Zero")
		
echo ""
echo "#### DOWNLOADING LibreELEC RPI1/ZERO URLs ####"
echo ""		
echo "LibreELEC latest release (Stable) ${LATEST}"
echo ""
#Download website source code
wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
#Correcting urls addresses
sed -i "s|Stable1|http://berrytest.alexgoldcheidt.com:50841/Downloads/Stable1|g" .download-link
#Selecting Rpi Build
sed -n '/Stable1*/p' .download-link > .download-link1
#Correcting Rpi1 url address
#sed -i "s|LibreELEC-RPi2|LibreELEC-RPi|g" .download-link1
#getting latest version
head -n1 .download-link1 > .download-link-final
echo ""
echo "#### DONE! ####"
echo ""
sleep 3
clear
echo ""
echo "#### DOWNLOADING LibreELEC RPI1/ZERO IMAGE ####"
echo ""
            aria2c -x 4 -s 4 -i ".download-link-final"
			clear
echo ""
echo "#### DECOMPRESSING LibreELEC RPI1/ZERO IMAGE ####"
echo ""
			sudo gunzip Stable1-LibreELEC*.img.gz
			sudo losetup -f -P Stable1-LibreELEC-RPi*.img
			sudo mount /dev/loop0p1 /mnt
			sudo unsquashfs /mnt/SYSTEM
			sudo umount /mnt
			sudo losetup -d /dev/loop0
clear
echo ""
echo "#### CONVERTING LibreELEC RPI1/ZERO IMAGE TO BERRYBOOT ####"
echo ""
			sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
			sudo mksquashfs squashfs-root/ libreelec.rpi1.zero.stable-${LATEST}.Berryboot-$date.img -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf Stable1-LibreELEC-RPi.arm* squashfs-root .download-link .download-link1 .download-link-final
			clear
echo ""
echo "#### RPI1/ZERO IMAGE READY! ####"
echo ""
echo "-----------------------------------------------";
echo "Support my project at: paypal.me/alexgoldc";
echo "-----------------------------------------------";

			break
            ;;
        "Raspberry Pi 2/3")
echo ""
echo "#### DOWNLOADING LibreELEC RPI2/RPI3 URLs ####"
echo ""		
echo "LibreELEC latest release (Stable) ${LATEST}"
echo ""
#Download website source code
wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
#Correcting urls addresses
sed -i "s|Stable2|http://berrytest.alexgoldcheidt.com:50841/Downloads/Stable2|g" .download-link
#Selecting Rpi Build
sed -n '/Stable2*/p' .download-link > .download-link1
#Correcting Rpi1 url address
#sed -i "s|LibreELEC-RPi2|LibreELEC-RPi|g" .download-link1
#getting latest version
tail -n1 .download-link1 > .download-link-final
echo ""
echo "#### DONE! ####"
echo ""
sleep 3
clear
echo ""
echo "#### DOWNLOADING LibreELEC RPI2/RPI3 IMAGE ####"
echo ""
            aria2c -x 4 -s 4 -i ".download-link-final"
			clear
echo ""
echo "#### DECOMPRESSING LibreELEC RPI2/RPI3 IMAGE ####"
echo ""
			sudo gunzip Stable2-LibreELEC*.img.gz
			sudo losetup -f -P Stable2-LibreELEC-RPi*.img
			sudo mount /dev/loop0p1 /mnt
			sudo unsquashfs /mnt/SYSTEM
			sudo umount /mnt
			sudo losetup -d /dev/loop0
clear
echo ""
echo "#### CONVERTING LibreELEC RPI2/RPI3 IMAGE TO BERRYBOOT ####"
echo ""
			sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
			sudo mksquashfs squashfs-root/ libreelec.rpi2.rpi3.stable-${LATEST}.Berryboot-$date.img -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf Stable2-LibreELEC-RPi2.arm* squashfs-root .download-link .download-link1 .download-link-final
			clear
echo ""
echo "#### RPI2/RPI3 IMAGE READY! ####"
echo ""
echo "-----------------------------------------------";
echo "Support my project at: paypal.me/alexgoldc";
echo "-----------------------------------------------";

			break
            ;;
			"All Raspberry Pi Devices")
echo ""
echo "#### DOWNLOADING LibreELEC RPI1/ZERO URLs ####"
echo ""		
echo "LibreELEC latest release (Stable) ${LATEST}"
echo ""
#Download website source code
wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
#Correcting urls addresses
sed -i "s|Stable1|http://berrytest.alexgoldcheidt.com:50841/Downloads/Stable1|g" .download-link
#Selecting Rpi Build
sed -n '/Stable1*/p' .download-link > .download-link1
#Correcting Rpi1 url address
#sed -i "s|LibreELEC-RPi2|LibreELEC-RPi|g" .download-link1
#getting latest version
head -n1 .download-link1 > .download-link-final
echo ""
echo "#### DONE! ####"
echo ""
sleep 3
clear
echo ""
echo "#### DOWNLOADING LibreELEC RPI1/ZERO IMAGE ####"
echo ""
            aria2c -x 4 -s 4 -i ".download-link-final"
			clear
echo ""
echo "#### DECOMPRESSING LibreELEC RPI1/ZERO IMAGE ####"
echo ""
			sudo gunzip Stable1-LibreELEC*.img.gz
			sudo losetup -f -P Stable1-LibreELEC-RPi*.img
			sudo mount /dev/loop0p1 /mnt
			sudo unsquashfs /mnt/SYSTEM
			sudo umount /mnt
			sudo losetup -d /dev/loop0
clear
echo ""
echo "#### CONVERTING LibreELEC RPI1/ZERO IMAGE TO BERRYBOOT ####"
echo ""
			sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
			sudo mksquashfs squashfs-root/ libreelec.rpi1.zero.stable-${LATEST}.Berryboot-$date.img -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf Stable1-LibreELEC-RPi.arm* squashfs-root .download-link .download-link1 .download-link-final
			clear
echo ""
echo "#### RPI1/ZERO IMAGE READY! ####"
echo ""
clear
echo ""
echo "#### DOWNLOADING LibreELEC RPI2/RPI3 URLs ####"
echo ""		
echo "LibreELEC latest release (Stable) ${LATEST}"
echo ""
#Download website source code
wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
#Correcting urls addresses
sed -i "s|Stable2|http://berrytest.alexgoldcheidt.com:50841/Downloads/Stable2|g" .download-link
#Selecting Rpi Build
sed -n '/Stable2*/p' .download-link > .download-link1
#Correcting Rpi1 url address
#sed -i "s|LibreELEC-RPi2|LibreELEC-RPi|g" .download-link1
#getting latest version
tail -n1 .download-link1 > .download-link-final
echo ""
echo "#### DONE! ####"
echo ""
sleep 3
clear
echo ""
echo "#### DOWNLOADING LibreELEC RPI2/RPI3 IMAGE ####"
echo ""
            aria2c -x 4 -s 4 -i ".download-link-final"
			clear
echo ""
echo "#### DECOMPRESSING LibreELEC RPI2/RPI3 IMAGE ####"
echo ""
			sudo gunzip Stable2-LibreELEC*.img.gz
			sudo losetup -f -P Stable2-LibreELEC-RPi*.img
			sudo mount /dev/loop0p1 /mnt
			sudo unsquashfs /mnt/SYSTEM
			sudo umount /mnt
			sudo losetup -d /dev/loop0
clear
echo ""
echo "#### CONVERTING LibreELEC RPI2/RPI3 IMAGE TO BERRYBOOT ####"
echo ""
			sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
			sudo mksquashfs squashfs-root/ libreelec.rpi2.rpi3.stable-${LATEST}.Berryboot-$date.img -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf Stable2-LibreELEC-RPi2.arm* squashfs-root .download-link .download-link1 .download-link-final
			clear
echo ""
echo "#### ALL LIBREELEC IMAGES READY! ####"
echo ""
echo "-----------------------------------------------";
echo "Support my project at: paypal.me/alexgoldc";
echo "-----------------------------------------------";

			break
            ;;
        "Exit")
            break
            ;;
        *) echo invalid option;;
    esac
done
