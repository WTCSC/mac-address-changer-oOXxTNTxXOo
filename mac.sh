#!/bin/bash
# ogMAC.txt - original mac address saved
# sudo ./mac.sh
# bash ./mac.sh
# example: bash ./mac.sh changemac 08:00:27:8d:c0:4d eth0

ChangeMaddress(){
    [[ "$newmac" =~ ^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$ ]] && echo "Valid MAC address" || echo "Invalid MAC address"
    sudo ip link set dev $interface address $newmac
}

case "$1" in # used cases as i thought they might work better than using function calls. 
    savemac) 
        #check for file ogMAC.txt
        #check for macaddress in ogMAC.txt
        interface=$3
        line_number=$(($(wc -l < ogMAC.txt)+1))
        ip link show $interface | awk '/ether/ {print $2}' | sed "s/^/$line_number - /" >> ogMAC.txt
    ;;
    showog)
        cat ogMAC.txt
    ;;
    changemac)
        interface=$3
        newmac=$2
        ChangeMaddress
    ;;
    safechange) 
        interface=$1
        newmac=$2
        [[ "$newmac" =~ ^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$ ]] && echo "Valid MAC address" || echo "Invalid MAC address"
        sudo ip ink set dev $interface down
        sudo ip link set dev $interface address $newmac
        sudo ip link set dev $interface up
    ;;
    ranmac)
        interface=$2
        newmac=$(printf '%02X:%02X:%02X:%02X:%02X:%02X\n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256]) 
        ChangeMaddress
    ;;
    scan)
        ip link show $interface | awk '/:/ {print $2}'
    ;;
    --help) echo "options are [scan][ranmac][changmac][savemac]"
            echo "you should also try running sudo or bash ./mac.sh if you arn't already"
    ;;
    *) echo "are you trying to use ./mac? for help try --help";;
esac