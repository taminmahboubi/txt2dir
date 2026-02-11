#!/bin/bash

shopt -s nullglob # stops bash from returning the string '*.txt' if no files exist


RED="\033[0;31m"
GREEN="\033[0;32m"
BOLD="\033[1m"
RESET="\033[0m"


files=( *.txt )
avbl_files="${#files[@]}"

check_files() {
	if [ "$avbl_files" -eq 0 ]; then
		echo -e "${RED}SEARCH FAILED:${RESET} No .txt files were found!"
	else
		echo -e "${GREEN}SUCCESS:${RESET} [$avbl_files] .txt files were found!"
	fi
}






echo -e "${BOLD}Select an option:${RESET}"

options=(
	"Create folders from .txt file"
	"Create folders dynamically"
	"Exit"
)

choice=$(printf "%s\n" "${options[@]}" | fzf --layout=reverse --height 30%)

# if user presses 'Esc' or hits 'Ctrl + C'
# stops the script from running with an empty variable
if [ -z "$choice" ]; then
	clear
	echo -e "${BOLD}NO SELECTION MADE!${RESET}"
	exit 0 
fi

case $choice in 
	"Create folders from .txt file")
		clear
		check_files
		;;
	"Create folders dynamically")
		clear
		;;
	"Exit")
		clear
		exit
		;;
	*)
		clear
		echo "ERROR: Invalid option"
		;;
esac



