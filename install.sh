#!/bin/bash

# Function to display status messages
show_status() {
		echo "$(tput setaf 4)>>> $1$(tput sgr0)"
}

bash_script="install-zsh.sh"
if [ -f "$bash_script" ]; then
		bash "./$bash_script"
else
		show_status "Error: $bash_script not found!"
fi

zsh_script="post-zsh.sh"
if [ -f "$zsh_script" ]; then
		zsh "./$zsh_script"
else
		show_status "Error: $zsh_script not found!"
fi
