#!/bin/zsh

# Function to display status messages
show_status() {
		echo "$(tput setaf 4)>>> $1$(tput sgr0)"
}

# Clone or update Oh My Zsh plugins and Spaceship theme
clone_or_update_plugin() {
		local repo_url="$1"
		local destination="$2"

		if [[ ! -d "$destination" ]]; then
				show_status "Cloning $destination..."
				git clone "$repo_url" "$destination"
		else
				show_status "$destination already exists. Updating..."
				(cd "$destination" && git pull origin)
		fi
}

# Install custom .zshrc
show_status "Installing custom .zshrc..."
curl -o ~/.zshrc https://gist.githubusercontent.com/jeremyfuksa/440f27c77537c3d2382431f589506e8e/raw/4a4cb841c285d12e6634761b5c50684685a89cc3/.zshrc
source ~/.zshrc

# Clear stock MOTD
show_status "Clearing stock MOTD..."
echo -n > /etc/motd

# Clone or update zsh-autosuggestions
clone_or_update_plugin "https://github.com/zsh-users/zsh-autosuggestions.git" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

# Clone or update zsh-syntax-highlighting
clone_or_update_plugin "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# Clone or update spaceship-prompt theme and create symlink for spaceship.zsh-theme
clone_or_update_plugin "https://github.com/denysdovhan/spaceship-prompt.git" "$ZSH_CUSTOM/themes/spaceship-prompt"
if [[ ! -e "$ZSH_CUSTOM/themes/spaceship.zsh-theme" ]]; then
		show_status "Creating symlink for spaceship.zsh-theme..."
		ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
else
		show_status "spaceship.zsh-theme symlink already exists."
fi

# Run the update-all command in zsh
show_status "Running update-all command in zsh..."
zsh -c "update-all"
