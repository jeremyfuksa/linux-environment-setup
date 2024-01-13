#!/bin/bash

# Function to prompt user for installation
prompt_install() {
		read -p "Do you want to install a new copy? (y/n): " choice
		case "$choice" in
				y|Y ) return 0;; # User wants to install
				n|N ) return 1;; # User does not want to install
				* ) return 2;;   # Invalid choice
		esac
}

# Function to backup existing file
backup_file() {
		local file="$1"
		local backup_dir="$HOME/.backup"
		local backup_file="$backup_dir/$(basename "$file")_backup_$(date +%Y%m%d%H%M%S)"

		echo "Backing up $file to $backup_file"
		mkdir -p "$backup_dir"
		cp "$file" "$backup_file"
}

# Function to perform installation for Antigen
perform_install_antigen() {
		local antigen_file="$1"
		
		# Backup existing Antigen file
		backup_file "$antigen_file"

		# Download the new Antigen file
		curl -L git.io/antigen > "$antigen_file"

		echo "Antigen installed successfully."
}

# Function to perform installation for Starship configuration
perform_install_starship() {
		local starship_file="$1"
		
		# Backup existing Starship configuration file
		backup_file "$starship_file"

		# Download the new Starship configuration file
		curl -o "$starship_file" https://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@raw.githubusercontent.com/jeremyfuksa/standard-pi-setup/main/starship.toml

		echo "Starship configuration installed successfully."
}

# Function to perform installation for .zshrc
perform_install_zshrc() {
		local zshrc_file="$1"
		
		# Backup existing .zshrc file
		backup_file "$zshrc_file"

		# Download the new .zshrc file
		curl -o "$zshrc_file" https://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@raw.githubusercontent.com/jeremyfuksa/standard-pi-setup/main/.zshrc

		# Additional logic, if needed
		echo ".zshrc installed successfully."
}

# Function to perform installation for .zprofile
perform_install_zprofile() {
		local zprofile_file="$1"
		
		# Backup existing .zprofile file
		backup_file "$zprofile_file"

		# Download the new .zprofile file
		curl -o "$zprofile_file" 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@https://raw.githubusercontent.com/jeremyfuksa/standard-pi-setup/main/.zprofile

		# Additional logic, if needed
		echo ".zprofile installed successfully."
}

# Check and create ~/.config directory
if [ ! -d "$HOME/.config" ]; then
		echo "Creating ~/.config directory..."
		mkdir "$HOME/.config"
else
		echo "~/.config directory already exists."
fi

# Check and install Antigen
antigen_file="$HOME/.config/antigen.zsh"
if ! [ -f "$antigen_file" ]; then
		echo "Installing Antigen (Zsh plugin manager)..."
		curl -L git.io/antigen > "$antigen_file"
else
		echo "Antigen is already installed."
		prompt_install || perform_install_antigen "$antigen_file"
fi

# Check and install Starship
starship_file="$HOME/.config/starship.toml"
if ! [ -f "$starship_file" ]; then
		echo "Downloading and saving Starship configuration..."
		curl -o "$starship_file" https://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@raw.githubusercontent.com/jeremyfuksa/standard-pi-setup/main/starship.toml
else
		echo "Starship configuration file already exists."
		prompt_install || perform_install_starship "$starship_file"
fi

# Check and install .zshrc
zshrc_file="$HOME/.zshrc"
if ! [ -f "$zshrc_file" ]; then
		echo "Downloading and saving .zshrc..."
		curl -o "$zshrc_file" https://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@raw.githubusercontent.com/jeremyfuksa/standard-pi-setup/main/.zshrc
		source "$zshrc_file"  # Assuming you want to source .zshrc after installing
else
		echo ".zshrc file already exists."
		prompt_install || perform_install_zshrc "$zshrc_file"
		source "$zshrc_file"  # Assuming you want to source .zshrc after installing
fi

# Check and install .zprofile
zprofile_file="$HOME/.zprofile"
if ! [ -f "$zprofile_file" ]; then
		echo "Downloading and saving .zprofile..."
		curl -o "$zprofile_file" https://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@raw.githubusercontent.com/jeremyfuksa/standard-pi-setup/main/.zprofile
		source "$zprofile_file"  # Assuming you want to source .zprofile after installing
else
		echo ".zprofile file already exists."
		prompt_install || perform_install_zprofile "$zprofile_file"
		source "$zprofile_file"  # Assuming you want to source .zprofile after installing
fi

echo "Setup completed."
