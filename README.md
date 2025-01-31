[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/tp86o73G)
[![Open in Codespaces](https://classroom.github.com/assets/launch-codespace-2972f46106e565e64193e422d61a12cf1da4916b45550586e14ef0a7c637dd04.svg)](https://classroom.github.com/open-in-codespaces?assignment_repo_id=17754093)

# To-Do 
1. - [x] backup the original MAC address for restoration 
2. - [x] change computers MAC address 
3. - [x] randomly generating MAC address 
4. - [x] scan the local network and list 
    1. - [x] detected MAC addresses 
    2. - [ ] corresponding vendors 
5. - [x] add input validation 
6. - [x] add error handling 
7. - [x] accept shell scripts 
8. - [ ] detailed read me 
    1. - [x] installation giude 
    2. - [x] usage example 
    3. - [x] explain error handling 
    4. - [x] troubleshooting tips 
    5. - [ ] screenshot/video/gif 

# Mac Address Manager
The Mac Address Manager is a tool that is cabable of automating the reconfiguration of your MAC Address. 

# how to set-up 
To setup MAC Address Manager you will need to install the mac.sh file and then make sure that the file is executible. you can make sure the file is executible by opening a terminal and verifiy that chmod +x mac.sh is enabled. 

# how to use
To use the MAC Address Manager you will need to run either the recomended: bash ./mac.sh --help or sudo ./mac.sh --help or ./mac.sh --help 

# Commands
the commands for the MAC Address Manager must be inserted directly after typing "./mac.sh" your terminal should look something like "bash ./mac.sh command"
here is the list of avalable commands and how they can be used. 
## --help
--help will output the list of avable commands. 
EX: bash ./mac.sh --help

## savemac
savemac will save the mac address of either your specified wireless interface controller or by default eth0. 
EX: bash ./mac.sh savemac 
or 
    bash ./mac.sh savemac eth1

## showog
showog will output in the terminal all the mac addressess you have saved.
EX: bash ./mac.sh showog

## changemac
The changemac command will change the mac address, to the address of your choosing, of your specified wireless interface controller or by default eth0
EX: bash ./mac.sh changemac 08:00:27:8d:c0:4d 
or 
    bash ./mac.sh changemac 08:00:27:8d:c0:4d eth0

## safechange
safechange is a command which performs the exact same thing that changemac does however safechange is differnt in performance when changing the mac address as safechange powers down your wireless interface controller before changing the mac address.
EX: bash ./mac.sh safechange 08:00:27:8d:c0:4d 
or 
    bash ./mac.sh safechange 08:00:27:8d:c0:4d eth0

## ranmac
ranmac is a command which changes your mac address to a completly random mac address. addionally ranmac can be specified to change the mac of a specific wireless interface controller. by default ranmac changes the mac address of eth0.
EX: bash ./mac.sh ranmac 
or 
    EX: bash ./mac.sh ranmac eth0

## scan
scan is a command that scan your machine for local wireless interface controllers and outputs each of thier mac addresses anc connected controller. 
EX: bash ./mac.sh scan

# Notes/bugs
ranmac does not always work the first time and may need to be ran a couple of times before successfully changing the mac address. 

when changing the mac addess over ssh connection you may need to shut down your virtual machine in a saved state in order to finalize the mac address change. this is an ongoing bug which I intended to fix however after some reaserch I could not find a solution to this problem on the contrary I am aware that it is possible to fix this issue. 

addionally all saved macs are saved on file ogMAC.txt and can be searched through manualy if need be. each mac address saved in this file should have a corresponding added number, corrected original interface controller name, and a mac address. EX: 1 - eth0 - 08:00:27:8d:c0:4d

minor bug when using savemac you may notice that the command outputs the wireless interface controller when ran. that output is fine as it is how the input validation process works. 