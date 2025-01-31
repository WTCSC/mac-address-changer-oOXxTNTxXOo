import subprocess
import sys
import re
# example: sudo python3 mac.py eth0 08:00:27:8d:c0:4d


#sets variables from terminal inputs
interface = sys.argv[1]
mac = sys.argv[2]


# for this function there are two differnt ways of implementing/using subprocess i made it like this becuase i think it could provide me with a good example of how to do use subporcess in differnt ways. 
#changes mac address with new mac address
if re.match("[0-9a-f]{2}([-:]?)[0-9a-f]{2}(\\1[0-9a-f]{2}){4}$", mac.lower()): # verifies mac address is valid
    subprocess.run(["ip", "link", "set", "dev", interface, "address", mac]) # changes mac address
    newmac = (subprocess.run(f"ip link show {interface} | awk '/ether/ {{print $2}}'", shell=True, capture_output=True, text=True)).stdout.strip()  # Verifies that the MAC address has changed  --- .stdout.strip() Extracts the new MAC address from the output 
    print(f"MAC address changed to {newmac}")
else:
    print("not a valid mac address")
