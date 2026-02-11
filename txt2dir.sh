#!/bin/bash

BOLD="\033[1m"
RESET="\033[0m"

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
		echo "Creating from file..."
		;;
	"Create folders dynamically")
		clear
		echo "creating dynamically..."
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



