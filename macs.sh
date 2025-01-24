#!/bin/bash
macs=$1
# c0:a7:de:29:62:d4
interface=$2
# eth0
sudo ip link set dev $interface address $macs
read MAC </sys/class/net/$interface/address
echo "updated: $interface $MAC"