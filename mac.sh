#!/bin/bash
#ogMAC.txt - original mac address saved
#sudo ./mac.sh

#sed -E 's/([0-9a-eA-E]{2}:){5}[0-9a-eA-E]{2}/XX:XX:XX:XX:XX:XX/g' Input_file


saveOgMAC(){
line_number=$(($(wc -l < ogMAC.txt)+1))
ip link show eth0 | awk '/ether/ {print $2}' | sed "s/^/$line_number - /" >> ogMAC.txt
cat ogMAC.txt
}
saveOgMAC