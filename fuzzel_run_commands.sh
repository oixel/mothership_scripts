#!/bin/bash

# Stores path to list of commands
commands="/home/oixel/.config/fuzzel/commands.json"

# Extract the keys from the commands.json and pip them into a fuzzel dmenu
# Then, take the selected command and store it into a variable
selected_command=$(jq --raw-output '. | to_entries[] | .key' "$commands" | fuzzel --dmenu --prompt "/" --placeholder "search commands")

# Called once a command is selected 
if [ -n "$selected_command" ]; then
	# Access selected command's functionality from commands.json
	function=$(jq -r ".[\"$selected_command\"]" "$commands")
	
	# If function is found, run it and then remove the process from the shell's job control
	if [ -n "$function" ]; then
		eval "$function" & disown
	fi
fi
