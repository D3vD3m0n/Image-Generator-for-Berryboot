#!/bin/bash

if [ "$EUID" -ne 0 ]
then 
    echo 1>&2 "Please run as root"
    exit 1
fi

#date
date=$(date +"%d-%b-%Y")

sleep 1
clear
#Some arwork...
echo "----------------------------------------------------------";
echo " _,_ _,_,  _    __, _    __,_  ,_____,_, _ _, _ _,_, _ _, ";
echo " |_//_\|   |    |_) |    |_ '\/  | |_ |\ |(_  |/ \|\ |(_  ";
echo " | \| || , |    |   |    |   /\  | |  | \|, ) |\ /| \|, ) ";
echo " ~ ~~ ~~~~ ~    ~   ~    ~~~~  ~ ~ ~~~~  ~ ~  ~ ~ ~  ~ ~  ";
echo "----------------------------------------------------------";

#base path to server
base="http://milhouse.KALI.tv/builds/master/RPi/"

#Names for Converted OS Images
NAME1="Kali_rolling_rpi1_zero_berryboot-$date.img"
NAME2="Kali_rolling_rpi2_rpi3_berryboot-$date.img"

echo ""
echo "#### Kali Rolling IMAGE GENERATOR FOR BERRYBOOT ####"
echo ""

#KALI DEV Image Menu Selection
PS3='Please select your device: '
options=("Raspberry Pi 1/Zero" "Raspberry Pi 2/3" "All Raspberry Pi Devices" "Banana Pi M2Z" "Banana Pi 1/2" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Raspberry Pi 1/Zero")
		
echo ""
echo "#### DOWNLOADING Kali RPI1/ZERO URLs ####"
echo ""	
echo "(Daily Build from Milhouse)"
echo ""	
# download website source code
wget -q -O - "http://milhouse.KALI.tv/builds/master/RPi/?C=M&O=D" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
# Correcting urls addresses
sed -i "s|Kali|http://milhouse.KALI.tv/builds/master/RPi/KALI|g" .download-link
#Selecting Rpi Build
sed -n '/Kali-RPi*/p' .download-link > .download-link1
# getting latest version
head -n1 .download-link1 > .download-link-final
echo ""
echo "#### DONE! ####"
echo ""
sleep 3
clear
echo ""
echo "#### DOWNLOADING Kali RPI1/ZERO IMAGE ####"
echo ""
            aria2c -x 4 -s 4 -i ".download-link-final"
			clear
echo ""
echo "#### DECOMPRESSING Kali RPI1/ZERO IMAGE ####"
echo ""
			sudo find . -name 'Kali-RPi.arm*.tar' -exec sh -c 'tar -xf $1' _ {} \;
			sudo find Kali-RPi.arm*/target/ -name 'SYSTEM' -exec sh -c 'unsquashfs $1' _ {} \;
clear
echo ""
echo "#### CONVERTING Kali RPI1/ZERO IMAGE TO BERRYBOOT ####"
echo ""
			sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
			sudo mksquashfs squashfs-root/ $NAME1 -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf KALI-RPi.arm* squashfs-root .download-link*
			clear
echo ""
echo "#### Kali RPI1/ZERO IMAGE READY! ####"
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
echo "(Daily Build from Milhouse)"
echo ""		
# download website source code
wget -q -O - "http://milhouse.KALI.tv/builds/master/RPi2/?C=M&O=D" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
# Correcting urls addresses
sed -i "s|KALI|http://milhouse.KALI.tv/builds/master/RPi2/KALI|g" .download-link
#Selecting Rpi Build
sed -n '/KALI-RPi*/p' .download-link > .download-link1
# getting latest version
head -n1 .download-link1 > .download-link-final
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
			sudo find . -name 'KALI-RPi2.arm*.tar' -exec sh -c 'tar -xf $1' _ {} \;
			sudo find KALI-RPi2.arm*/target/ -name 'SYSTEM' -exec sh -c 'unsquashfs $1' _ {} \;
clear
echo ""
echo "#### CONVERTING KALI RPI2/RPI3 IMAGE TO BERRYBOOT ####"
echo ""
			sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
			sudo mksquashfs squashfs-root/ $NAME2 -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf KALI-RPi2.arm* squashfs-root .download-link*
			clear
echo ""
echo "#### KALI RPI2/RPI3 IMAGE READY! ####"
echo ""
echo "-----------------------------------------------";
echo "Support my project at: paypal.me/alexgoldc";
echo "-----------------------------------------------";
			break
            ;;
"Banana Pi M2Z"

			"All Raspberry Pi Devices")
echo ""
echo "#### DOWNLOADING KALI RPI1/ZERO URLs ####"
echo ""	
echo "(Daily Build from Milhouse)"
echo ""		
# download website source code
wget -q -O - "http://milhouse.KALI.tv/builds/master/RPi/?C=M&O=D" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
# Correcting urls addresses
sed -i "s|KALI|http://milhouse.KALI.tv/builds/master/RPi/KALI|g" .download-link
#Selecting Rpi Build
sed -n '/KALI-RPi*/p' .download-link > .download-link1
# getting latest version
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
			sudo find . -name 'KALI-RPi.arm*.tar' -exec sh -c 'tar -xf $1' _ {} \;
			sudo find KALI-RPi.arm*/target/ -name 'SYSTEM' -exec sh -c 'unsquashfs $1' _ {} \;
clear
echo ""
echo "#### CONVERTING KALI RPI1/ZERO IMAGE TO BERRYBOOT ####"
echo ""
			sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
			sudo mksquashfs squashfs-root/ $NAME1 -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf KALI-RPi.arm* squashfs-root .download-link*
			clear
echo ""
echo "#### KALI RPI1/ZERO IMAGE READY! ####"
echo ""
clear
echo ""
echo "#### DOWNLOADING KALI RPI2/RPI3 URLs ####"
echo ""		
echo "(Daily Build from Milhouse)"
echo ""	
# download website source code
wget -q -O - "http://milhouse.KALI.tv/builds/master/RPi2/?C=M&O=D" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' > .download-link
# Correcting urls addresses
sed -i "s|KALI|http://milhouse.KALI.tv/builds/master/RPi2/KALI|g" .download-link
#Selecting Rpi Build
sed -n '/KALI-RPi*/p' .download-link > .download-link1
# getting latest version
head -n1 .download-link1 > .download-link-final
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
			sudo find . -name 'KALI-RPi2.arm*.tar' -exec sh -c 'tar -xf $1' _ {} \;
			sudo find KALI-RPi2.arm*/target/ -name 'SYSTEM' -exec sh -c 'unsquashfs $1' _ {} \;
clear
echo ""
echo "#### CONVERTING KALI RPI2/RPI3 IMAGE TO BERRYBOOT ####"
echo ""
			sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
			sudo mksquashfs squashfs-root/ $NAME2 -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
			sudo rm -rf KALI-RPi2.arm* squashfs-root .download-link*
			clear
echo ""
echo "#### ALL KALI IMAGES READY! ####"
echo ""
echo "-----------------------------------------------";
echo "-----------------------------------------------";
			break
            ;;
        "Exit")
            break
            ;;
        *) echo invalid option;;
    esac
done
