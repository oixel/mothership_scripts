#!/bin/bash

# Store first parameter as the new menu choice
new_choice="$1"

# Stores the directory of cache of currently opened menu choice 
choice_cache="$HOME/.cache/fuzzel_open_menu"

# Define the different fuzzel menu open commands
# (This is essentially a SWITCH statement
case $new_choice in
	applications)		
		# Opens apps menu (checks for .desktop files)
		open_command="fuzzel --prompt '> ' --placeholder 'search apps'" 
	;;
	
	clipboard)
		# Opens clipboard menu (uses cliphist)
		open_command="cliphist list | fuzzel --dmenu --prompt '󱘢 ' --placeholder 'search copies' | cliphist decode | wl-copy"
	;;

	emojis)
		# Opens emojis menu (uses bemoji)
		# -n removes new line after emoji
		# -t inserts emoji using wtype (instead of copying it)
		# Launch command is specified as env in hyprland.conf
		open_command="bemoji -n -t"
	;;

	commands)
		# Opens custom commands menu
		# Commands are declared in the commands.json
		# (located in ~/.config/fuzzle/
		open_command="~/.local/share/scripts/fuzzel_run_commands.sh"
	;;
esac

#
# Handle menu toggling logic
# 	- If not in menu, simply open new one
# 	- If in menu
# 		- Attempting to open same menu? Close menu
# 		- New menu? Swap to it
#
if ! pgrep -x fuzzel >/dev/null
then
	# If no menu is open, open requested menu
	echo "$new_choice" > "$choice_cache"
	eval "$open_command"
else  # Otherwise, if menu is opening...
	# If new menu...
	if [ "$new_choice" != "$(cat "$choice_cache")" ]
	then
		# Close currently opened menu
		killall fuzzel

		# Store new menu choice in cache
		echo "$new_choice" > "$choice_cache"

		# Open the new menu!
		eval "$open_command"

	else  # If attempting to open same menu, toggle it closed
		killall fuzzel
		rm -f "$choice_cache"
	fi
fi	
