#!/bin/bash

echo "Setting up your environment..."

# Function to prompt user for installation
prompt_install() {
		read -p "Do you want to install a new copy? (y/n): " choice
		case "$choice" in
				y|Y ) return 0;; # User wants to install
				n|N ) return 1;; # User does not want to install
				* ) return 2;;   # Invalid choice
		esac
}

# Check if zsh is already the default shell
if [ "$(basename "$SHELL")" != "zsh" ]; then
		echo "Changing default shell to Zsh..."
		sudo apt-get update && apt-get install -y zsh bc git
		chsh -s $(which zsh)
else
		echo "Zsh is already the default shell."
fi

# Check and create ~/.config directory
if [ ! -d "$HOME/.config" ]; then
		echo "Creating ~/.config directory..."
		mkdir "$HOME/.config"
else
		echo "~/.config directory already exists."
fi

# Check and install Antigen
if ! [ -f "$HOME/.config/antigen.zsh" ]; then
		echo "Installing Antigen (Zsh plugin manager)..."
		curl -L git.io/antigen > "$HOME/.config/antigen.zsh"
else
		echo "Antigen is already installed."
		prompt_install || exit 0
fi

# Check and install Starship
if ! command -v starship &> /dev/null; then
		echo "Installing Starship (Shell prompt)..."
		sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
else
		echo "Starship is already installed."
		prompt_install || exit 0
fi

# Check and download Starship configuration
if [ ! -f "$HOME/.config/starship.toml" ]; then
		echo "Downloading and saving Starship configuration..."
		curl -o "$HOME/.config/starship.toml" https://raw.githubusercontent.com/jeremyfuksa/linux-environment-setup/main/starship.toml
else
		echo "Starship configuration file already exists."
		prompt_install || exit 0
fi

# Check and download .zshrc
if ! [ -f "$HOME/.zshrc" ]; then
		echo "Downloading and saving .zshrc..."
		curl -o "$HOME/.zshrc" https://raw.githubusercontent.com/jeremyfuksa/linux-environment-setup/main/.zshrc
		source "$HOME/.zshrc"
else
		echo ".zshrc file already exists."
		prompt_install || exit 0
fi

# Check and download .zprofile
if ! [ -f "$HOME/.zprofile" ]; then
		echo "Downloading and saving .zprofile..."
		curl -o "$HOME/.zprofile" https://raw.githubusercontent.com/jeremyfuksa/linux-environment-setup/main/.zprofile
		source "$HOME/.zprofile"
else
		echo ".zprofile file already exists."
		prompt_install || exit 0
fi

echo "Environment setup completed."
