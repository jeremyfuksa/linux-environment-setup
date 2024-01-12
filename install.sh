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
	echo "Creating Starship configuration file..."
	touch "$HOME/.config/starship.toml"
	cat << 'EOF' > $HOME/.config/starship.toml
	"$schema" = 'https://starship.rs/config-schema.json'
	add_newline = true
	
	[aws]
	symbol = " "
	
	[buf]
	symbol = " "
	
	[c]
	symbol = " "
	
	[character]
	format = ' [➝](bold gray) '
	success_symbol = '[➝](bold green) '
	error_symbol = '[➝](bold red) '
	
	[conda]
	symbol = " "
	
	[crystal]
	symbol = " "
	
	[dart]
	symbol = " "
	
	[directory]
	read_only = " 󰌾"
	
	[docker_context]
	symbol = " "
	
	[elixir]
	symbol = " "
	
	[elm]
	symbol = " "
	
	[fennel]
	symbol = " "
	
	[fossil_branch]
	symbol = " "
	
	[git_branch]
	symbol = " "
	
	[golang]
	symbol = " "
	
	[guix_shell]
	symbol = " "
	
	[haskell]
	symbol = " "
	
	[haxe]
	symbol = " "
	
	[hg_branch]
	symbol = " "
	
	[hostname]
	ssh_symbol = " "
	format = '[$ssh_symbol](bold blue) on [$hostname](bold red) '
	
	[java]
	symbol = " "
	
	[julia]
	symbol = " "
	
	[kotlin]
	symbol = " "
	
	[lua]
	symbol = " "
	
	[memory_usage]
	symbol = "󰍛 "
	
	[meson]
	symbol = "󰔷 "
	
	[nim]
	symbol = "󰆥 "
	
	[nix_shell]
	symbol = " "
	
	[nodejs]
	symbol = " "
	
	[ocaml]
	symbol = " "
	
	[os.symbols]
	Alpaquita = " "
	Alpine = " "
	Amazon = " "
	Android = " "
	Arch = " "
	Artix = " "
	CentOS = " "
	Debian = " "
	DragonFly = " "
	Emscripten = " "
	EndeavourOS = " "
	Fedora = " "
	FreeBSD = " "
	Garuda = "󰛓 "
	Gentoo = " "
	HardenedBSD = "󰞌 "
	Illumos = "󰈸 "
	Linux = " "
	Mabox = " "
	Macos = " "
	Manjaro = " "
	Mariner = " "
	MidnightBSD = " "
	Mint = " "
	NetBSD = " "
	NixOS = " "
	OpenBSD = "󰈺 "
	openSUSE = " "
	OracleLinux = "󰌷 "
	Pop = " "
	Raspbian = " "
	Redhat = " "
	RedHatEnterprise = " "
	Redox = "󰀘 "
	Solus = "󰠳 "
	SUSE = " "
	Ubuntu = " "
	Unknown = " "
	Windows = "󰍲 "
	
	[package]
	symbol = "󰏗 "
	
	[perl]
	symbol = " "
	
	[php]
	symbol = " "
	
	[pijul_channel]
	symbol = " "
	
	[python]
	symbol = " "
	
	[rlang]
	symbol = "󰟔 "
	
	[ruby]
	symbol = " "
	
	[rust]
	symbol = " "
	
	[scala]
	symbol = " "
	
	[swift]
	symbol = " "
	
	[zig]
	symbol = " "
	EOF
else
	echo "Starship configuration file already exists."
fi

# Check if .zshrc exists
if ! [ -f "$HOME/.zshrc" ]; then
	echo "Configuring zsh..."
	cat << 'EOF' > $HOME/.zshrc
	source ~/.config/antigen.zsh
	
	antigen bundle lukechilds/zsh-nvm
	antigen bundle lukechilds/zsh-better-npm-completion
	antigen bundle zsh-users/zsh-syntax-highlighting
	antigen bundle zsh-users/zsh-autosuggestions
	antigen bundle zsh-users/zsh-completions
	antigen apply
	
	# Remove if not a Raspberry Pi in a Geekworm SATA case
	alias xoff='sudo /usr/local/bin/x-c1-softsd.sh'
	
	update_git_repo() {
		local repo_path="$1"
		cd "$repo_path" || return 1
		git pull origin
		cd -
	}
	
	update-all() {
		(
			# update_git_repo "$ZSH_CUSTOM/themes/spaceship-prompt"
			sudo apt update -y
			sudo apt upgrade -y
			sudo apt autoremove -y
		)
	}
	
	install() {
		if [ $# -eq 0 ]; then
			echo "Usage: install package1 [package2 ...]"
			return 1
		fi
	
		(command sudo apt install -y "$@")
	}
	
	ngensite() {
		if [ $# -eq 1 ]; then
			ln -s "/etc/nginx/sites-available/$1" "/etc/nginx/sites-enabled/$1"
			echo "Site enabled: $1"
		else
			echo "Usage: ngensite <site_name>"
		fi
	}
	
	ngdissite() {
		if [ $# -eq 1 ]; then
			rm "/etc/nginx/sites-enabled/$1"
			echo "Site disabled: $1"
		else
			echo "Usage: ngdissite <site_name>"
		fi
	}
	
	bindkey '[C' forward-word
	
	eval "$(starship init zsh)"
	EOF
else
	echo ".zshrc file already exists."
fi

echo "Environment setup completed."
source ~/.zshrc
