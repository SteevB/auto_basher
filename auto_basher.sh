#!/bin/bash
# ===============================================================================
#   FILE: auto_basher.sh
#
#   USAGE: auto_basher.sh
#
#   DESCRIPTION:  Simplifies memory testing by auto running sys_basher and saving results in time specified folders.
#       OPTIONS:  No Current Options Available
#   REQUIRMENTS:  Linux based OS with sys_basher installed
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Stephen K Briles
#       COMPANY:  Black Diamond Memory
#       VERSION:  0.3
#       CREATED:  04.26.2016 - XX:XX
#      REVISION:  04.28.2016 - 13:06
# ===============================================================================


# Variables:
#   >> Time of Testing
currentTime=$(date +"%H:%M:%S")
currentDate=$(date +"%m-%d-%y")
fullDate=$(date +"%A, %D")
startTime=${currentDate}_${currentTime}
revision="0.3"

#   >> Save Location
DIRECTORY="/home/$USER/sys_basher"

#   >> System Information
totalMemory=$(free -m | awk '/^Mem:/{print $2}')
availableMemory=$(free -m | awk '/^Mem:/{print $4}')

#   >> Menu Selections/Information
title=">> Auto_Basher Main Menu <<"
prompt=$'\nPlease Select Testing Mode:'
options=("Address - Data Tests" "Bank Tests" "Fixed Pattern Tests" "Random Data Tests" "Walking Ones/Zeros Data Tests" "Bit Reversed Address Tests" "All Tests")
# Functions

function startup_message {
  clear
  printf "\n======================================================================\n"
  printf "\nBlack Diamond Memory Sys_basher Script\n   Revision: $revision \n\nTesting Information >>\n   Time: "$currentTime"\n   Date: "$fullDate"\n   User: "$USER
  printf "\n\nGathering System Infromation >>\n "
  printf "  Total System Memory: $totalMemory MB\n\n"
  printf "This software will test for errors and reliability in memory modules.\nIf you do not wish to do this, then please exit the program now.\n\n"
  printf "======================================================================\n\n"
}
# Create time specified directory for individual test saves and report results to user
function make_save_location {
  printf "Creating Test Results Save Directory....."
  sleep 2s
  mkdir SBT_$startTime
  cd SBT_$startTime
  printf "\n\n>>> Current Save Location:  "; pwd
  printf "\n\n==============STOP ALL OTHER PROCESSES BEFORE CONTINUING==============\n"

}
#   >> Starts Sys_basher memory only tests
function start_basher_promt {
  printf "\nNow Starting Sys_basher...\n\n"
  printf "\n\n"
  sleep 6s
}

#   >> Verifies user wants to start sys_basher
function confirmation {
  read -p "If you wish to continue press [ENTER], otherwise exit with CTRL + C"
  printf "\n\n"
}

# Main Menu Function and Selections
function main_menu {
printf "\n$title\n\n"
PS3="$prompt "
select opt in "${options[@]}" "Quit"
  do
      case $opt in
          "Address - Data Tests" )
              clear
              printf "Selected 'Address - Data Tests'"
              start_basher_promt
              sys_basher -t 256 -mem [a] -st -r SBT_$startTime
              ;;
          "Bank Tests" )
              clear
              printf "Selected 'Bank Tests'"
              start_basher_promt
              sys_basher -t 256 -mem [b] -st -r SBT_$startTime
              ;;
          "Fixed Pattern Tests" )
              clear
              printf "Selected 'Fixed Pattern Tests'"
              start_basher_promt
              sys_basher -t 256 -mem [p] -st -r SBT_$startTime
              ;;
          "Random Data Tests" )
              clear
              printf "Selected 'Random Data Tests'"
              start_basher_promt
              sys_basher -t 256 -mem [r] -st -r SBT_$startTime
              ;;
          "Walking Ones/Zeros Data Tests" )
              clear
              printf "Selected 'Walking Ones/Zeros Data Tests'"
              start_basher_promt
              sys_basher -t 256 -mem [w] -st -r SBT_$startTime
              ;;
          "Bit Reversed Address Tests" )
              clear
              printf "Selected 'Bit Reversed Address Tests'"
              start_basher_promt
              sys_basher -t 256 -mem [v] -st -r SBT_$startTime
              ;;
          "All" )
              clear
              printf "Selected to Run All Tests"
              start_basher_promt
              sys_basher -t 256 -m -st -r SBT_$startTime
              ;;
          "Quit" )
              clear
              break
              ;;
          * )
              clear
              printf "INVALID SELECTION - PLEASE TRY AGAIN\n"
              main_menu
              ;;
      esac
  done
}

#   >> Checks to see if parent save directory exists [/home/$USER/sys_basher]
  if [ -d "$DIRECTORY" ]
  then
    clear
    cd $DIRECTORY
    startup_message
    confirmation
    make_save_location
    main_menu

  else
    # If sys_basher directory doesn't exist, it will be created.
    clear
    mkdir /home/$USER/sys_basher
  fi




# End of File
