#!/usr/bin/env bash

SCRIPT_NAME=setup_script_example.sh
if ([[ -n "${BASH_VERSION}" &&  "${BASH_SOURCE}" == "$0" ]] ||
    [[ -n "${ZSH_EVAL_CONTEXT}" && "${ZSH_EVAL_CONTEXT}" == "toplevel" ]]); then
        echo "Please execute as '. ./${SCRIPT_NAME}'"
        exit
fi

# Global variables
GLOBAL_VARIABLE1="Global variable"

# Exports - this is where we need sourcing (. ./setup_script_example.sh)
export EXPORTED_VARIABLE="Exported variable"

# Whiptail configuration
export NEWT_COLORS='root=,green
    roottext=blue,white
    entry=blue,white'
SETUP_WINDOW_TITLE="The setup title can go here"
WINDOW_HEIGHT=10
WINDOW_WIDTH=100

function show_info_box(){
    whiptail --title "Info:" --backtitle "${SETUP_WINDOW_TITLE}" --msgbox "$1" ${WINDOW_HEIGHT} ${WINDOW_WIDTH}
}

function show_yesno_box(){
    whiptail --title "Conditional action:" --backtitle "${SETUP_WINDOW_TITLE}" --yesno "$1" ${WINDOW_HEIGHT} ${WINDOW_WIDTH}
}

function show_input_box(){
    whiptail --title "User input:" --backtitle "${SETUP_WINDOW_TITLE}" --inputbox "$1" ${WINDOW_HEIGHT} ${WINDOW_WIDTH} 3>&1 1>&2 2>&3
}

function wait_for_keypress(){
  local color=`tput setaf 4`
  local reset=`tput sgr0`
  local message="Press any key to continue..."

  if [[ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]]; then
     read "?${color}${message}${reset}"
  elif [[ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]]; then
     read -p "${color}${message}${reset}"
  else
     read -p "${color}${message}${reset}"
  fi
}

function setup_step1(){
    show_info_box "This is how we can show some info box, for example a global var: ${GLOBAL_VARIABLE1}"
}

function setup_step2(){
    if show_yesno_box "Shall I do some conditional action?"; then
        echo "work is done!"
        wait_for_keypress
    fi
}

setup_step1
setup_step2