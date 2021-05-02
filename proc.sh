#! /bin/bash


# FUNCTION DEFINITIONS:

PromptUser() {
    read -n 1 -s -r -p "Press [q] key to continue..." key
    while [ "$key" != "q" ]
    do
       read -n 1 -s -r -p "Press [q] key to continue..." key
       echo
    done
    clear
}



if (($# != 1))
then
   echo 'Error due to inaccurate number of arguments. Only 1 allowed.'
   exit 1
fi


while read -p "Enter your choice [1 - 4]:" ; do
  case $REPLY in
    1) echo "$(ps aux | less)"
       PromptUser;;
    2) read -p "Please enter the PID of the process you would like to kill: " PID 
       kill $"${PID}"
       PromptUser;;
    3) echo "Press [q] to exit top."
       top
       PromptUser;;
    4) break;;

  esac
done




