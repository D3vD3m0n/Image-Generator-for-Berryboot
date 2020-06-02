#!/bin/bash

if [ "$EUID" -ne 0 ]
then 
    echo 1>&2 "Please run as root"
    exit 1
fi

#date
date=$(date +"%d-%b-%Y")

#show version 
LATEST=$( wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/testing.i" )
clear

#Some arwork...
echo "----------------------------------------------------------";
echo " _,_ _,_,  _    __, _    __,_  ,_____,_, _ _, _ _,_, _ _, ";
echo " |_//_\|   |    |_) |    |_ '\/  | |_ |\ |(_  |/ \|\ |(_  ";
echo " | \| || , |    |   |    |   /\  | |  | \|, ) |\ /| \|, ) ";
echo " ~ ~~ ~~~~ ~    ~   ~    ~~~~  ~ ~ ~~~~  ~ ~  ~ ~ ~  ~ ~  ";
echo "----------------------------------------------------------";

echo ""
echo "#### KALI TESTING IMAGE GENERATOR FOR BERRYBOOT ####"
echo ""

#KALI Testing Image Menu Selection
PS3='Please select your device: '
options=("Raspberry Pi 1/Zero" "Raspberry Pi 2/3" "All Raspberry Pi Devices" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Raspberry Pi 1/Zero")
		
echo ""
echo "#### DOWNLOADING KALI RPI1/ZERO URLs ####"
echo ""		
echo "KALI latest release (Testing) ${LATEST}"
echo ""
#Download website source code
wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
#Correcting urls addresses
sed -i "s|Testing1|http://berrytest.alexgoldcheidt.com:50841/Downloads/Testing1|g" .download-link
#Selecting Rpi Build
sed -n '/Testing1*/p' .download-link > .download-link1
#Correcting Rpi1 url address
#sed -i "s|KALI-RPi2|KALI-RPi|g" .download-link1
#getting latest version
head -n1 .download-link1 > .download-link-final
echo ""
echo "#### DONE! ####"
echo ""
sleep 3
clear
echo ""
echo "#### DOWNLOADING KALI RPI1/ZERO IMAGE ####"
echo ""
            aria2c -x 4 -s 4 -i ".download-link-final"
			clear
echo ""
echo "#### DECOMPRESSING KALI RPI1/ZERO IMAGE ####"
echo ""
			sudo gunzip Testing1-KALI*.img.gz
			sudo losetup -f -P Testing1-KALI-RPi*.img
			sudo mount /dev/loop0p1 /mnt
			sudo unsquashfs /mnt/SYSTEM
			sudo umount /mnt
			sudo losetup -d /dev/loop0
clear
echo ""
echo "#### CONVERTING KALI RPI1/ZERO IMAGE TO BERRYBOOT ####"
echo ""
			sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
			sudo mksquashfs squashfs-root/ KALI.rpi1.zero.testing-${LATEST}.Berryboot-$date.img -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf Testing1-KALI-RPi.arm* squashfs-root .download-link .download-link1 .download-link-final
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
echo "#### DOWNLOADING KALI RPI2/RPI3 URLs ####"
echo ""		
echo "KALI latest release (Testing) ${LATEST}"
echo ""
#Download website source code
wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
#Correcting urls addresses
sed -i "s|Testing2|http://berrytest.alexgoldcheidt.com:50841/Downloads/Testing2|g" .download-link
#Selecting Rpi Build
sed -n '/Testing2*/p' .download-link > .download-link1
#Correcting Rpi1 url address
#sed -i "s|KALI-RPi2|KALI-RPi|g" .download-link1
#getting latest version
tail -n1 .download-link1 > .download-link-final
echo ""
echo "#### DONE! ####"
echo ""
sleep 3
clear
echo ""
echo "#### DOWNLOADING KALI RPI2/RPI3 IMAGE ####"
echo ""
            aria2c -x 4 -s 4 -i ".download-link-final"
			clear
echo ""
echo "#### DECOMPRESSING KALI RPI2/RPI3 IMAGE ####"
echo ""
			sudo gunzip Testing2-KALI*.img.gz
			sudo losetup -f -P Testing2-KALI-RPi*.img
			sudo mount /dev/loop0p1 /mnt
			sudo unsquashfs /mnt/SYSTEM
			sudo umount /mnt
			sudo losetup -d /dev/loop0
clear
echo ""
echo "#### CONVERTING KALI RPI2/RPI3 IMAGE TO BERRYBOOT ####"
echo ""
			sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
			sudo mksquashfs squashfs-root/ KALI.rpi2.rpi3.testing-${LATEST}.Berryboot-$date.img -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf Testing2-KALI-RPi2.arm* squashfs-root .download-link .download-link1 .download-link-final
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
echo "#### DOWNLOADING KALI RPI1/ZERO URLs ####"
echo ""		
echo "KALI latest release (Testing) ${LATEST}"
echo ""
#Download website source code
wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
#Correcting urls addresses
sed -i "s|Testing1|http://berrytest.alexgoldcheidt.com:50841/Downloads/Testing1|g" .download-link
#Selecting Rpi Build
sed -n '/Testing1*/p' .download-link > .download-link1
#Correcting Rpi1 url address
#sed -i "s|KALI-RPi2|KALI-RPi|g" .download-link1
#getting latest version
head -n1 .download-link1 > .download-link-final
echo ""
echo "#### DONE! ####"
echo ""
sleep 3
clear
echo ""
echo "#### DOWNLOADING KALI RPI1/ZERO IMAGE ####"
echo ""
            aria2c -x 4 -s 4 -i ".download-link-final"
			clear
echo ""
echo "#### DECOMPRESSING KALI RPI1/ZERO IMAGE ####"
echo ""
			sudo gunzip Testing1-KALI*.img.gz
			sudo losetup -f -P Testing1-KALI-RPi*.img
			sudo mount /dev/loop0p1 /mnt
			sudo unsquashfs /mnt/SYSTEM
			sudo umount /mnt
			sudo losetup -d /dev/loop0
clear
echo ""
echo "#### CONVERTING KALI RPI1/ZERO IMAGE TO BERRYBOOT ####"
echo ""
			sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
			sudo mksquashfs squashfs-root/ KALI.rpi1.zero.testing-${LATEST}.Berryboot-$date.img -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf Testing1-KALI-RPi.arm* squashfs-root .download-link .download-link1 .download-link-final
			clear
echo ""
echo "#### RPI1/ZERO IMAGE READY! ####"
echo ""
clear
echo ""
echo "#### DOWNLOADING KALI RPI2/RPI3 URLs ####"
echo ""		
echo "KALI latest release (Testing) ${LATEST}"
echo ""
#Download website source code
wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
#Correcting urls addresses
sed -i "s|Testing2|http://berrytest.alexgoldcheidt.com:50841/Downloads/Testing2|g" .download-link
#Selecting Rpi Build
sed -n '/Testing2*/p' .download-link > .download-link1
#Correcting Rpi1 url address
#sed -i "s|KALI-RPi2|KALI-RPi|g" .download-link1
#getting latest version
tail -n1 .download-link1 > .download-link-final
echo ""
echo "#### DONE! ####"
echo ""
sleep 3
clear
echo ""
echo "#### DOWNLOADING KALI RPI2/RPI3 IMAGE ####"
echo ""
            aria2c -x 4 -s 4 -i ".download-link-final"
			clear
echo ""
echo "#### DECOMPRESSING KALI RPI2/RPI3 IMAGE ####"
echo ""
			sudo gunzip Testing2-KALI*.img.gz
			sudo losetup -f -P Testing2-KALI-RPi*.img
			sudo mount /dev/loop0p1 /mnt
			sudo unsquashfs /mnt/SYSTEM
			sudo umount /mnt
			sudo losetup -d /dev/loop0
clear
echo ""
echo "#### CONVERTING KALI RPI2/RPI3 IMAGE TO BERRYBOOT ####"
echo ""
			sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
			sudo mksquashfs squashfs-root/ KALI.rpi2.rpi3.testing-${LATEST}.Berryboot-$date.img -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf Testing2-KALI-RPi2.arm* squashfs-root .download-link .download-link1 .download-link-final
			clear
echo ""
echo "#### ALL KALI IMAGES READY! ####"
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
