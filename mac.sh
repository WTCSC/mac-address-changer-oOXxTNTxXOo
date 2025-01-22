#!/bin/bash
#ogMAC.txt - original mac address saved
#sudo ./mac.sh
#bash ./mac.sh

#sed -E 's/([0-9a-eA-E]{2}:){5}[0-9a-eA-E]{2}/XX:XX:XX:XX:XX:XX/g' Input_file
#grep -io '[0-9a-f]\{12\}' file.txt > macs.txt

#add error checking for if mac already in ogmac then it wont add.

#grabs mac address and saves to file
saveOgMAC(){ 
line_number=$(($(wc -l < ogMAC.txt)+1))
# ip link show eth0 | awk '/ether/ {print $2}' | sed "s/^/$line_number - /" >> ogMAC.txt
macadds=$(ip link show eth0 | awk '/ether/ {print $2}' | sed "s/^/$line_number - /")
#echo "$macadds"
admac=$(echo $macadds | awk '{print $3}')
kill=$(echo $admac | awk -F: '{print $1":"$2":"$3}')
# ranum=$(printf ':%02X:%02X:%02X\n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
# ran=$(echo $kill$ranum)
printf $kill':%02X:%02X:%02X\n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] 
# echo "$admac"
# echo "$kill"
# echo "$ran"
# cat ogMAC.txt
}


# saveOgMAC

#printf '08-00-27-%02X-%02X-%02X\n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256]


# Define the network interface and new MAC address

# Bring the interface down
# sudo ip link set $INTERFACE down

# Change the MAC address
# sudo ip link set $INTERFACE address $NEW_MAC

# Bring the interface up
# sudo ip link set $INTERFACE up

# Verify the change
# ip link show $INTERFACE | grep ether

#08:00:27:01:d4:0f
#sudo ip link add eth1 type dummy
#sudo systemctl restart networking
#sudo ip link set dev $interface address 02:01:02:03:04:08

#ip link add vmnic0 type dummy
#ip link set vmnic0 addr 00:15:5d:35:ea:15

#ip link add vmnic0 type bridge
#ip link add vmnic0 type bond
#ip tuntap add vmnic0 mode tap