#!/bin/bash

shopt -s nullglob # stops bash from returning the string '*.txt' if no files exist

RED="\033[0;31m"
GREEN="\033[0;32m"
BOLD="\033[1m"
RESET="\033[0m"

LOGFILE="activity.txt"

files=( *.txt ) 

log_message() {
	echo "$(date '+Date: %Y-%m-%d, Hour: %H:%M:%S') - $1" >> "$LOGFILE"
}

num_of_files() {
	local count=0
	for file in "${files[@]}"; do
		if [[ "$file" != "activity.txt" ]]; then
			(( count++ ))
		fi
	done

	echo "$count"
}


make_folder() {
	mkdir -p "$1"
	local msg="SUCCESS: Folder $1 CREATED!"
	log_message "$msg"
	echo -e "${GREEN}$msg${RESET}"
}

list_files() {
	
	# don't want 'activity.txt' to be included so, create a new list
	local folders=()
	for file in "${files[@]}"; do
		if [[  "$file" != "activity.txt" ]]; then
			folders+=( "$file" ) # parentheses tells bash its a new element in the list
		fi
	done

		
	# create a new fzf for listed files
	local choice=$(printf "%s\n" "${folders[@]}" | fzf --layout=reverse --height 30% --preview 'cat {}')
	
	# if the user presses 'Esc' or hits 'Ctrl + C'
	# stops the script from running with an empty variable
	if [ -z "$choice" ]; then
		clear
		echo -e "${BOLD}NO SELECTION MADE!${RESET}"
		exit
	fi
	

	while read -r foldername; do
		# skip lines that are empty
		if [ -z "$foldername" ]; then    # "zero length"
			continue  		 # skip rest of code and jump to next line
		fi
		
		# skip lines that start with a hashtag (comments)
		if [[ "$foldername" == "#"* ]]; then
			continue
		fi
		
					
		make_folder "$foldername"
	done < "$choice"
}


check_files() {
	if [ "$(num_of_files)" -eq 0 ]; then
		echo -e "${RED}SEARCH FAILED:${RESET} No .txt files were found!"
	else
		echo -e "${GREEN}SUCCESS:${RESET} [$(num_of_files)] .txt files were found!"
		list_files
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



