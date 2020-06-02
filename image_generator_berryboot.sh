#!/bin/bash

#image Generator for Berryboot

if [ "$EUID" -ne 0 ]
then 
    echo 1>&2 "Please run as root"
    exit 1
fi

#date
date=$(date +"%d-%b-%Y")

sleep 1
clear
#Some artwork...
echo "----------------------------------------------------------";
echo " _,_ _,_,  _    __, _    __,_  ,_____,_, _ _, _ _,_, _ _, ";
echo " |_//_\|   |    |_) |    |_ '\/  | |_ |\ |(_  |/ \|\ |(_  ";
echo " | \| || , |    |   |    |   /\  | |  | \|, ) |\ /| \|, ) ";
echo " ~ ~~ ~~~~ ~    ~   ~    ~~~~  ~ ~ ~~~~  ~ ~  ~ ~ ~  ~ ~  ";
echo "----------------------------------------------------------";
echo ""
echo "#### INSTALLING DEPENDENCIES ####"
echo ""

#OS Menu Selection
PS3='Please select your OS: '
options=("Skip" "Debian/Ubuntu" "CentOS" "Fedora" "ArchLinux")
select opt in "${options[@]}"
do
    case $opt in
        "Debian/Ubuntu")
		
echo ""
echo "#### INSTALLING ARIA2/SQUASHFS-TOOLS ####"
echo ""		
#installing packages
sudo apt-get update && sudo apt-get install aria2 squashfs-tools -y
echo ""
echo "#### DONE! ####"
echo ""
sleep 1
clear
			break
            ;;
        "CentOS")
echo ""
echo "#### INSTALLING ARIA2/SQUASHFS-TOOLS ####"
echo ""		
#installing packages
sudo yum install aria2 squashfs-tools -y
echo ""
echo "#### DONE! ####"
echo ""
sleep 1
clear
			break
            ;;
			"Fedora")
echo ""
echo "#### INSTALLING ARIA2/SQUASHFS-TOOLS ####"
echo ""		
#installing packages
sudo dnf install aria2 squashfs-tools -y
echo ""
echo "#### DONE! ####"
echo ""
sleep 1
clear
			break
            ;;
			"ArchLinux")
echo ""
echo "#### INSTALLING ARIA2/SQUASHFS-TOOLS ####"
echo ""		
#installing packages
pacman -Syy --noconfirm aria2 squashfs-tools --force
echo ""
echo "#### DONE! ####"
echo ""
sleep 1
clear
			break
			;;
        "Skip")
            break
            ;;
        *) echo invalid option;;
    esac
done
sleep 1
clear

#     ___  ___   ___      _        _   _          
#    / _ \/ __| / __| ___| |___ __| |_(_)___ _ _  
#   | (_) \__ \ \__ \/ -_) / -_) _|  _| / _ \ ' \ 
#    \___/|___/ |___/\___|_\___\__|\__|_\___/_||_|
#                                                 

echo ""
echo "#### OPERATING SYSTEM SELECTION ####"
echo ""

#OS Menu Selection
PS3='Please select the OS: '
options=("Android" "Kali Linux" "Ubuntu eoan" "Debian (dosbian_v1.5)" "RetroPie Armbian" "LibreELEC (Kodi)" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "LibreELEC (Kodi)")
#Starting LibreELEC Script
bash <(wget -qO- https://github.com/D3vD3m0n/Image-Generator-for-Berryboot/blob/master/os-selection/libreelec/libreelec_by_berryserver.sh)
		break
            ;;
        "Kali Linux")
bash <(wget -qO- https://github.com/D3vD3m0n/Image-Generator-for-Berryboot/blob/master/os-selection/kali/Kali_2020_2a_berryboot.sh)
		break
            ;;
        "Android")
bash <(wget -qO- https://github.com/D3vD3m0n/Image-Generator-for-Berryboot/blob/master/os-selection/android/android_by_berryserver.sh)
		break
            ;;
        "Ubuntu eoan")
bash <(wget -qO- https://github.com/D3vD3m0n/Image-Generator-for-Berryboot/blob/master/os-selection/ubuntu/ubuntu_by_berryserver.sh)
		break
            ;;
        "Debian (dosbian_v1.5)")
bash <(wget -qO- https://github.com/D3vD3m0n/Image-Generator-for-Berryboot/blob/master/os-selection/debian/debian_by_berryserver.sh)
		break
            ;;
        "RetroPie Armbian")
bash <(wget -qO- https://github.com/D3vD3m0n/Image-Generator-for-Berryboot/blob/master/os-selection/retropie/retropie_by_berryserver.sh)
		break
            ;;
        "Exit")
            break
            ;;
        *) echo invalid option;;
    esac    
done
