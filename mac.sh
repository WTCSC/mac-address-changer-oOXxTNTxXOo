#!/bin/bash
#ogMAC.txt - original mac address saved
jill= ip link show eth0 | awk '/ether/ {print $2}' > ogMAC.txt

cat ogMAC.txt
