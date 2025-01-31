#!/bin/bash
# ogMAC.txt - original mac address saved
# sudo ./mac.sh
# bash ./mac.sh
# example: bash ./mac.sh changemac 08:00:27:8d:c0:4d eth0

# i made changing the address a function as i figured i may need to call back to this specific function more than once in the project.
ChangeMaddress(){
    # the code the line below works by checking the validation of the new mac address then if it functions it will contrinue and echo that the mac address is valid for the end user and if it fails it will echo that the mac address is not valid. 
    [[ "$newmac" =~ ^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$ ]] && echo "Valid MAC address" || echo "Invalid MAC address"  # to simplify this verifies that the user inputed mac address is in a valid address format however it does not check for if it is a valid mac address.
    sudo ip link set dev $interface address $newmac   # simply chnages the mac address of the specified wireless interface controller. 
}

# i made this a function as i figured this would be easier to add to the input one line validation for checking if the wireless interface controller does exist. 
macsave(){
    if grep -q "$addr" "ogMAC.txt"; then # checks for if mac address is already saved within the save file. if yes it will inform the end user, if no it will save the mac address and inform the end user.
        echo "Mac address already saved"
    else
        line_number=$(($(wc -l < ogMAC.txt)+1)) # counts line for save file. I added this becuase I originally intended the save file to only be dated by number for each new saved mac address. 
        ip link show $interface | awk '/ether/ {print $2}' | sed "s/^/$line_number - $interface - /" >> ogMAC.txt # adds information to save file.
        echo "mac address saved"
    fi
}

case "$1" in # used cases as i thought they might work better than using function calls. 
    savemac) 
        # default wireless interface controller.
        interface="${2:-"eth0"}"  # Use the first argument, or default value if not provided for the interface. 
        addr=$(ip link show $interface | awk '/ether/ {print $2}') # grabs the mac address. 
        ip link | grep -oP '(?<=^).*(?=: <)' | awk '{print $2}' | grep $interface && macsave || echo "interface controller does not exist" # varifies that wireless controller exist by seeing if it exist if it does it will run the save command if it doesnt it will error and echo the error back to the end user. 
    ;;
    showog)
        cat ogMAC.txt # I only cated the ogMAC.txt file as i figured saved mac dont realy need to be specified. 
    ;;
    changemac)
        # simple - changes the mac address without careing to turn of the wireless interface controller first. I used this solution as it works for what i need it for.
        # default wireless interface controller.
        interface="${3:-"eth0"}"  # Use the first argument, or default value if not provided for the interface. 
        newmac=$2
        ChangeMaddress
    ;;
    safechange) 
        # I included safe change as I figured changemac may not always work and safechange should be a backup for when changemac dosent change the mac address or if someone likes to power off ther tech and change the mac after for safety/security reason however I dont truly know. 
        # default wireless interface controller.
        interface="${3:-"eth0"}"  # Use the first argument, or default value if not provided for the interface. 
        newmac=$2
        [[ "$newmac" =~ ^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$ ]] && echo "Valid MAC address" || echo "Invalid MAC address" # i gave safe change its own checks as i felt this would be eaiser then trying to use the same function for all mac address chanegs. 
        sudo ip ink set dev $interface down # turns off the wireless interface controller
        sudo ip link set dev $interface address $newmac # changes the mac address
        sudo ip link set dev $interface up # turn the wireles interface controller back on
    ;;
    ranmac)
        # default wireless interface controller.
        interface="${2:-"eth0"}"  # Use the first argument, or default value if not provided for the interface.
        newmac=$(printf '%02X:%02X:%02X:%02X:%02X:%02X\n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256]) #outputs random mac address. 
        ChangeMaddress
    ;;
    scan) ip link show $interface | awk '/:/ {print $2}';; # I couldn't understand how to scan the network so i figured the next best option would be to scan the local machine. 
    --help) 
        #i made help simple as i wanted to be lazy. I am aware i could add more to the help but i figured most of what help realy needs should have been already explained in the read me. 
        echo "./mac.sh command options are [scan][ranmac][changmac][safechange][savemac][showog]"
        echo "you should also try running sudo or bash ./mac.sh if you arn't already"
    ;;
    *) echo "are you trying to use ./mac? for help try --help";; #I only added this as i figured it should help the end user if they misspell something. 
esac