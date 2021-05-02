#! /bin/bash


#-- args not allowed
if (($# != 0))
then
   echo 'Error due to inaccurate number of arguments. None allowed.'
   exit 1
fi


PromptUser() {
    read -n 1 -s -r -p "Press [Enter] key to continue..." key
    while [ ! -z "$key" ]
    do
        read -n 1 -s -r key
    done
} 



#-- Show main menu...
MainMenu () {
    clear
    echo
    DATE=$(date)
    echo "$DATE"
    echo "----------------------------------------------------------------------------"
    echo "  Main Menu  "
    echo "----------------------------------------------------------------------------"
    echo " 1. Operating system info."
    echo " 2. Hostname and DNS info."
    echo " 3. Network info."
    echo " 4. Who is online?"
    echo " 5. Last logged in users"
    echo " 6. My IP Address"
    echo " 7. My Disk Usage"
    echo " 8. My Home File-Tree"
    echo " 9. Process Operations"
    echo "10. Exit"
}


#-- Show OS info - selected 1
systemInfo () {
    clear
    echo "----------------------------------------------------------------------------"
    echo "  System information  "
    echo "----------------------------------------------------------------------------"
    cat /etc/os-release
    PromptUser; 
}

#-- Hostname, DNS Info - selection 2
hostDNSInfo () {
    clear
    echo "----------------------------------------------------------------------------"
    echo "  Hostname and DNS information  "
    echo "----------------------------------------------------------------------------"
    host=$(hostname -A)
    echo "Hostname: $host"
    dns=$(hostname -d) #name of the DNS domain
    echo "DNS domain: $dns "
    fqdn=$(hostname --fqdn)
    echo "Fully qualified domain name: $fqdn"
    ip=$(hostname -i)
    echo "Network address (IP): $ip"
    nameservers=$(dnsdomainname -A)
    echo "DNS name servers (DNS IP): $nameservers"
    PromptUser;
}

#-- Show Network Info...
networkInfo () {
    clear
    echo "----------------------------------------------------------------------------"
    echo "  Network information  "
    echo "----------------------------------------------------------------------------"
    
    netint=$(ls /sys/class/net | wc -l)
    printf "Total network interfaces found: %s\n" $netint

    echo "*** IP Addresses Information ***"
    ip addr show
    echo "********************************"
    echo "*** Network routing ***"
    netstat -rn
    echo "********************************"
    echo "*** Interface traffic information ***"
    netstat -i
    PromptUser;
}


#-- Show who is logged in...
whosloggedin () {
    clear
    echo "----------------------------------------------------------------------------"
    echo "  Who is online  "
    echo "----------------------------------------------------------------------------"
    who -H
    PromptUser;
}

#-- Show list of last logged in users...
lastloggedusers() {
    clear
    echo "----------------------------------------------------------------------------"
    echo "  List of last logged in users  "
    echo "----------------------------------------------------------------------------"
    who -u
    PromptUser; 
}

#-- Show current IP address
showIP() {
    clear
    echo "----------------------------------------------------------------------------"
    echo "  Public IP information  "
    echo "----------------------------------------------------------------------------"
    ip=$(hostname -i)
    echo $ip
    PromptUser;
}

#-- Show current disk usage
diskuse() {
    clear
    echo "----------------------------------------------------------------------------"
    echo "  Disk Usage Info  "
    echo "----------------------------------------------------------------------------"
    df -H --output=pcent,source
    PromptUser;
}

#-- Run project 1 script...
execproj1script() {
    clear
    echo "----------------------------------------------------------------------------"
    echo "  My Home file-tree  "
    echo "----------------------------------------------------------------------------"

    chmod +x proj1.sh
    
    ./proj1.sh

    PromptUser; 
}


# 10. Displays a variety of process operations
processcommands() {
    clear
    echo "----------------------------------------------------------------------------"
    echo "  Process Operations  "
    echo "----------------------------------------------------------------------------"

    echo "(please enter the number of your selection below): "

    choice=-1

    while [ $choice -ne 4 ]
    do
        clear

        echo "----------------------------------------------------------------------------"
        echo "  Process Operations  "
        echo "----------------------------------------------------------------------------"

        echo "1.    Show all processes"
        echo "2.    Kill a process"
        echo "3.    Bring up top"
        echo "4.    Return to Main Menu"
        echo

        read -p "=> " choice
    
        if [ $choice == 1 ]
        then
            ./proc.sh 1
        elif [ $choice == 2 ]
        then
            ./proc.sh 2
        elif [ $choice == 3 ]
        then
            ./proc.sh 3
        else
            echo
        fi
    done
}



#-- MAIN LOOP SELECTION...
clear
echo "----------------------------------------------------------------------------"
echo "  ECE3524 -Project 3 "
echo "----------------------------------------------------------------------------"

while read -p "Enter your choice [1 - 10]:" ; do
  case $REPLY in
    1) systemInfo;;
    2) hostDNSInfo;;
    3) networkInfo;;
    4) whosloggedin;;
    5) lastloggedusers;;
    6) showIP;;
    7) diskuse;;
    8) execproj1script;;
    9) processcommands;;
    10) break;;

  esac
done



exit



