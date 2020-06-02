#!/bin/bash

if [ "$EUID" -ne 0 ]
then 
    echo 1>&2 "Please run as root"
    exit 1
fi

#date
date=$(date +"%d-%b-%Y")
#show version 
#LATEST=$( wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/stable.i" )
clear

#Some arwork...
echo "----------------------------------------------------------";
echo " _,_ _,_,  _    __, _    __,_  ,_____,_, _ _, _ _,_, _ _, ";
echo " |_//_\|   |    |_) |    |_ '\/  | |_ |\ |(_  |/ \|\ |(_  ";
echo " | \| || , |    |   |    |   /\  | |  | \|, ) |\ /| \|, ) ";
echo " ~ ~~ ~~~~ ~    ~   ~    ~~~~  ~ ~ ~~~~  ~ ~  ~ ~ ~  ~ ~  ";
echo "----------------------------------------------------------";

echo ""
echo "#### KALI STABLE IMAGE GENERATOR FOR BERRYBOOT ####"
echo ""

#KALI Stable Image Menu Selection
PS3='Please select your device: '
options=("Raspberry Pi 1/Zero" "Raspberry Pi 2/3" "All Raspberry Pi Devices" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Raspberry Pi 1/Zero")
		
echo ""
echo "#### DOWNLOADING KALI RPI1/ZERO URLs ####"
echo ""		
echo "KALI latest release (Stable)"
echo ""
#Download website source code
##wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
#Correcting urls addresses
#sed -i "s|Stable1|http://berrytest.alexgoldcheidt.com:50841/Downloads/Stable1|g" .download-link
#Selecting Rpi Build
#sed -n '/Stable1*/p' .download-link > .download-link1
#Correcting Rpi1 url address
#sed -i "s|KALI-RPi2|KALI-RPi|g" .download-link1
#getting latest version
#head -n1 .download-link1 > .download-link-final
echo ""
sleep 3
clear
echo ""
echo "#### DOWNLOADING KALI RPI1/ZERO IMAGE ####"
echo ""
            aria2c -x 4 -s 4 -i "http://berrytest.alexgoldcheidt.com:50841/Berryboot_OS_Testing/kali_linux_nexmon_v2020.2_rpi1_zero_2020.05.12_berryboot.img.gz"
			#".download-link-final"
			clear
echo ""
echo "#### DECOMPRESSING KALI RPI1/ZERO IMAGE ####"
echo ""     kali_linux_nexmon_v2020.2_rpi1_zero_2020.05.12_berryboot.img.gz
			sudo gunzip kali_linux_*.img.gz
			sudo losetup -f -P kali_linux_*.img
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
			sudo mksquashfs squashfs-root/ KALI.rpi1.zero.stable-${LATEST}.Berryboot-$date.img -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf kali_linux_*.img squashfs-root 
			clear
echo ""
echo "-----------------------------------------------";
echo "#### RPI1/ZERO IMAGE READY! ####"
echo "-----------------------------------------------";

			break
            ;;
        "Raspberry Pi 2/3")
echo ""
echo "#### DOWNLOADING KALI RPI2/RPI3 URLs ####"
echo ""		
echo "KALI latest release (Stable)"
echo ""
sleep 3
clear
echo ""
echo "#### DOWNLOADING KALI RPI2/RPI3 IMAGE ####"
echo ""
            aria2c -x 4 -s 4 -i "http://berrytest.alexgoldcheidt.com:50841/Berryboot_OS_Testing/kali_linux_nexmon_v2020.2_rpi2_rpi3_2020.05.12_berryboot.img.gz"
			clear
echo ""
echo "#### DECOMPRESSING KALI RPI2/RPI3 IMAGE ####"
echo ""
			sudo gunzip kali_linux_*.img.gz
			sudo losetup -f -P kali_linux_*.img
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
			sudo mksquashfs squashfs-root/ KALI.rpi2.rpi3.stable.Berryboot-$date.img -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf kali_linux_*.img squashfs-root .download-link .download-link1 .download-link-final
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
echo "KALI latest release (Stable) ${LATEST}"
echo ""
#Download website source code
wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
#Correcting urls addresses
sed -i "s|Stable1|http://berrytest.alexgoldcheidt.com:50841/Downloads/Stable1|g" .download-link
#Selecting Rpi Build
sed -n '/Stable1*/p' .download-link > .download-link1
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
			sudo gunzip Stable1-KALI*.img.gz
			sudo losetup -f -P Stable1-KALI-RPi*.img
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
			sudo mksquashfs squashfs-root/ KALI.rpi1.zero.stable-${LATEST}.Berryboot-$date.img -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf Stable1-KALI-RPi.arm* squashfs-root .download-link .download-link1 .download-link-final
			clear
echo ""
echo "#### RPI1/ZERO IMAGE READY! ####"
echo ""
clear
echo ""
echo "#### DOWNLOADING KALI RPI2/RPI3 URLs ####"
echo ""		
echo "KALI latest release (Stable) ${LATEST}"
echo ""
#Download website source code
wget -q -O - "http://berrytest.alexgoldcheidt.com:50841/Downloads/" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
#Correcting urls addresses
sed -i "s|Stable2|http://berrytest.alexgoldcheidt.com:50841/Downloads/Stable2|g" .download-link
#Selecting Rpi Build
sed -n '/Stable2*/p' .download-link > .download-link1
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
			sudo gunzip Stable2-KALI*.img.gz
			sudo losetup -f -P Stable2-KALI-RPi*.img
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
			sudo mksquashfs squashfs-root/ KALI.rpi2.rpi3.stable-${LATEST}.Berryboot-$date.img -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf Stable2-KALI-RPi2.arm* squashfs-root .download-link .download-link1 .download-link-final
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
