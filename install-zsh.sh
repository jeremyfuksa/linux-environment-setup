#!/bin/bash

# Function to display status messages
show_status() {
		echo "$(tput setaf 4)>>> $1$(tput sgr0)"
}

# Check if Oh My Zsh is installed
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
		# Install prerequisites
		show_status "Installing prerequisites..."
		sudo apt update && sudo apt upgrade
		sudo apt install -y zsh git bc

		# Install and enable Oh My Zsh
		show_status "Installing and enabling Oh My Zsh..."
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
		show_status "Oh My Zsh is already installed. Skipping installation."
fi
