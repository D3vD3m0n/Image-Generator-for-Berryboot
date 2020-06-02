#!/bin/bash
set -o errexit  # stop execution on error
given_file=$1 # retrieve input parameter and populate a variable

if [ "$EUID" -ne 0 ]; then 
    echo 1>&2 "Please run as root"
    exit 1
fi

#date
date=$(date +"%d-%b-%Y")

sleep 1
clear
echo ""
echo "#### KALI LINUX Image SELECTION ####"
echo ""

if [ -z given_file  ]; then
    read -p "Enter image path: " $given_file
fi

if [ -f given_file  ]; then
     #echo do something here file does exist
else 
    read -p "Enter image path: " $given_file
    if [ -f given_file  ]; then
       echo 1>&2 "Image OK..."
    else
       echo 1>&2 "Please run as root"
       exit 1
    fi
fi

sleep 1
clear
#Some arwork...
echo "----------------------------------------------------------";
echo " _,_ _,_,  _    __, _    __,_  ,_____,_, _ _, _ _,_, _ _, ";
echo " |_//_\|   |    |_) |    |_ '\/  | |_ |\ |(_  |/ \|\ |(_  ";
echo " | \| || , |    |   |    |   /\  | |  | \|, ) |\ /| \|, ) ";
echo " ~ ~~ ~~~~ ~    ~   ~    ~~~~  ~ ~ ~~~~  ~ ~  ~ ~ ~  ~ ~  ";
echo "----------------------------------------------------------";
echo "####    Kali   IMAGE   GENERATOR   FOR    BERRYBOOT    ####"

#base path to server
base="http://milhouse.KALI.tv/builds/master/RPi/"

#Names for Converted OS Images
NAME1="Kali_rolling_rpi1_zero_berryboot-$date.img"
NAME2="Kali_rolling_rpi2_rpi3_berryboot-$date.img"
NAME3="Kali_rolling_bpi1_bpizero_berryboot-$date.img"

PS3='Please select your device: '
options=("Raspberry Pi 1/Zero" "Raspberry Pi 2/3" "All Raspberry Pi Devices" "Banana Pi M2Z" "Banana Pi 1/2" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Raspberry Pi 1/Zero")
		
echo ""
echo "#### DECOMPRESSING Kali RPI1/ZERO IMAGE ####"
 if [ -f given_file  ]; then
    #sudo kpartx -av $given_file    
    #sudo find /home/me -not -type d -exec chmod 640 {} \;
    #add map loop0p1 (252:5): 0 117187 linear /dev/loop0 1
    #add map loop0p2 (252:6): 0 3493888 linear /dev/loop0 118784
    #sudo mount /dev/mapper/loop0p2 /squashfs-root   
    #sudo find . -name 'kali-linux-*.img' $given_file
	#sudo find . -name 'kali-linux-*.img' -exec sh -c 'kpartx -av $1' _ {} \;
	#sudo find kali-linux-*/target/ -name 'SYSTEM' -exec sh -c 'unsquashfs $1' _ {} \;
    echo "" 
	sudo losetup -f -P $given_file
	sudo mount /dev/loop0p1 /mnt
	sudo unsquashfs /mnt/SYSTEM
	sudo umount /mnt
	sudo losetup -d /dev/loop0
    clear
else
	sudo gunzip kali-linux-*.img.gz
	sudo losetup -f -P kali-linux-*.img
	sudo mount /dev/loop0p1 /mnt
	sudo unsquashfs /mnt/SYSTEM
	sudo umount /mnt
	sudo losetup -d /dev/loop0
	#sudo find . -name 'Kali-RPi.arm*.tar' -exec sh -c 'tar -xf $1' _ {} \;
	#sudo find Kali-RPi.arm*/target/ -name 'SYSTEM' -exec sh -c 'unsquashfs $1' _ {} \;
fi 
clear
echo ""
echo "#### CONVERTING Kali RPI1/ZERO IMAGE TO BERRYBOOT ####"
echo ""
			sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
			sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
            sudo rm -f /squashfs-root/etc/console-setup/cached_UTF-8_del.kmap.gz
            sudo rm -f /squashfs-root/etc/systemd/system/multi-user.target.wants/apply_noobs_os_config.service
            sudo rm -f /squashfs-root/etc/systemd/system/multi-user.target.wants/raspberrypi-net-mods.service
            sudo rm -f /squashfs-root/etc/rc3.d/S01resize2fs_once
			sudo mksquashfs squashfs-root/ $NAME1 -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
            sudo kpartx -d $given_file 
            sudo rm -rf KALI-RPi.arm* squashfs-root 
			clear
echo ""
echo "-----------------------------------------------";
echo "#### Kali RPI1/ZERO IMAGE READY! ####"
echo "-----------------------------------------------";
			break
            ;;
        "Raspberry Pi 2/3")
echo ""
echo "#### DECOMPRESSING KALI RPI2/RPI3 IMAGE ####"
 if [ -f given_file  ]; then
	sudo losetup -f -P $given_file
	sudo mount /dev/loop0p1 /mnt
	sudo unsquashfs /mnt/SYSTEM
	sudo umount /mnt
	sudo losetup -d /dev/loop0
    clear
else
	sudo gunzip kali-linux-*.img.gz
	sudo losetup -f -P kali-linux-*.img
	sudo mount /dev/loop0p1 /mnt
	sudo unsquashfs /mnt/SYSTEM
	sudo umount /mnt
	sudo losetup -d /dev/loop0
fi 
echo ""
echo "#### CONVERTING KALI RPI2/RPI3 IMAGE TO BERRYBOOT ####"
echo ""
	sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
	sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
	sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
	sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
    sudo rm -f /squashfs-root/etc/console-setup/cached_UTF-8_del.kmap.gz
    sudo rm -f /squashfs-root/etc/systemd/system/multi-user.target.wants/apply_noobs_os_config.service
    sudo rm -f /squashfs-root/etc/systemd/system/multi-user.target.wants/raspberrypi-net-mods.service
    sudo rm -f /squashfs-root/etc/rc3.d/S01resize2fs_once
	sudo mksquashfs squashfs-root/ $NAME2 -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
	sudo kpartx -d $given_file 
    sudo rm -rf KALI-RPi2.arm* squashfs-root 
	clear
echo ""
echo "-----------------------------------------------";
echo "#### KALI RPI2/RPI3 IMAGE READY! ####"
echo "-----------------------------------------------";
			break
            ;;
            "Banana Pi M2Z")
echo ""
echo "#### DECOMPRESSING KALI Banana Pi M2Z IMAGE ####"
 if [ -f given_file  ]; then
	sudo losetup -f -P $given_file
	sudo mount /dev/loop0p1 /mnt
	sudo unsquashfs /mnt/SYSTEM
	sudo umount /mnt
	sudo losetup -d /dev/loop0
    clear
else
	sudo gunzip kali-linux-*.img.gz
	sudo losetup -f -P kali-linux-*.img
	sudo mount /dev/loop0p1 /mnt
	sudo unsquashfs /mnt/SYSTEM
	sudo umount /mnt
	sudo losetup -d /dev/loop0
fi 
echo ""
echo "#### CONVERTING KALI Banana Pi M2Z IMAGE TO BERRYBOOT ####"
echo ""
	sudo sed -i 's/^\/dev\/mmcblk/#\0/g' squashfs-root/etc/fstab
	sudo sed -i 's/^\PARTUUID/#\0/g' squashfs-root/etc/fstab
	sudo sed -i 's/^\UUID/#\0/g' squashfs-root/etc/fstab
	sudo sed -i 's/^\LABEL/#\0/g' squashfs-root/etc/fstab
    sudo rm -f /squashfs-root/etc/console-setup/cached_UTF-8_del.kmap.gz
    sudo rm -f /squashfs-root/etc/systemd/system/multi-user.target.wants/apply_noobs_os_config.service
    sudo rm -f /squashfs-root/etc/systemd/system/multi-user.target.wants/raspberrypi-net-mods.service
    sudo rm -f /squashfs-root/etc/rc3.d/S01resize2fs_once
    sudo mksquashfs squashfs-root/ $NAME3 -comp lzo -e lib/modules var/cache/apt/archives var/lib/apt/lists
	sudo kpartx -d $given_file 
    sudo rm -rf KALI-RPi.arm* squashfs-root
	clear
echo ""
echo "-----------------------------------------------";
echo "#### KALI Banana Pi M2Z IMAGE READY! ####"
echo "-----------------------------------------------";
echo ""
			break
            ;;
        "Exit")
            break
            ;;
        *) echo invalid option;;
    esac


done
