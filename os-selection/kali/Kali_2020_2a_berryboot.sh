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
echo ""
echo "#### KALI LINUX BUILD SELECTION ####"
echo ""

#LibreELEC ALPHA Image Menu Selection
PS3='Please select KALI LINUX build: '
options=("Select a Image" "KALI LINUX Rolling Builds [2020]" "KALI LINUX Stable Builds [2020]" "KALI LINUX Testing Builds [2020]" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "KALI LINUX Stable Builds [2020]")

#Starting Script
bash <(wget -qO- https://github.com/D3vD3m0n/Image-Generator-for-Berryboot/blob/master/os-selection/kali/Kali_2020_2a_official_stable_builds_berryboot.sh)
		break
            ;;
        "KALI LINUX Testing Builds [2020]")
		
#Starting Script
bash <(wget -qO- https://github.com/D3vD3m0n/Image-Generator-for-Berryboot/blob/master/os-selection/kali/Kali_2020_2a_official_testing_builds_berryboot.sh)
		break
            ;;
			"KALI LINUX Rolling Builds [2020]")
			
#Starting Script
bash <(wget -qO- https://github.com/D3vD3m0n/Image-Generator-for-Berryboot/blob/master/os-selection/kali/Kali_2020_2a_dev_builds_berryboot.sh)
		break
            ;;
        "Select a Image")
			
#Starting Script
bash <(wget -qO- https://github.com/D3vD3m0n/Image-Generator-for-Berryboot/blob/master/os-selection/kali/image_berryboot.sh)
		break
            ;;
        "Exit")
            break
            ;;
        *) echo invalid option;;
    esac
done
