#!/bin/bash

echo "Setting up your environment..."

# Check if zsh is already the default shell
if [ "$(basename "$SHELL")" != "zsh" ]; then
		echo "Changing default shell to Zsh..."
		sudo apt-get update && apt-get install -y zsh bc git
		chsh -s $(which zsh)
else
		echo "Zsh is already the default shell."
fi

if [ ! -d "$HOME/.config" ]; then
		echo "Creating ~/.config directory..."
		mkdir "$HOME/.config"
else
		echo "~/.config directory already exists."
fi

# Check if Antigen is installed
if ! [ -f "$HOME/.config/antigen.zsh" ]; then
		echo "Installing Antigen (Zsh plugin manager)..."
		curl -L git.io/antigen > $HOME/.config/antigen.zsh
else
		echo "Antigen is already installed."
fi

# Check if Starship is installed
if ! command -v starship &> /dev/null; then
		echo "Installing Starship (Shell prompt)..."
		sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
else
		echo "Starship is already installed."
fi

# Check if Starship configuration file exists
if [ ! -f "$HOME/.config/starship.toml" ]; then
	echo "Downloading and saving Starship configuration..."
	curl -o "$HOME/.config/starship.toml" https://raw.githubusercontent.com/jeremyfuksa/standard-pi-setup/main/starship.toml
else
	echo "Starship configuration file already exists."
fi

# Check if .zshrc exists
if ! [ -f "$HOME/.zshrc" ]; then
	echo "Downloading and saving .zshrc..."
	curl -o "$HOME/.zshrc" https://raw.githubusercontent.com/jeremyfuksa/standard-pi-setup/main/.zshrc
	source ~/.zshrc
else
	echo ".zshrc file already exists."
fi

# Check if .zprofile exists
if ! [ -f "$HOME/.zprofile" ]; then
		echo "Downloading and saving .zprofile..."
		curl -o "$HOME/.zprofile" https://raw.githubusercontent.com/jeremyfuksa/standard-pi-setup/main/.zprofile
		source ~/.zprofile
else
		echo ".zprofile file already exists."
fi

echo "Environment setup completed."
