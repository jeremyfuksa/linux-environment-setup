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