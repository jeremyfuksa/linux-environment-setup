export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ADD_NEWLINE="true"
SPACESHIP_CHAR_SYMBOL=" ➜ "
SPACESHIP_CHAR_PREFIX="\ue709"
SPACESHIP_CHAR_SUFFIX=(" ")
SPACESHIP_CHAR_COLOR_SUCCESS="green"
SPACESHIP_PROMPT_DEFAULT_PREFIX="$USER"
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="true"
SPACESHIP_USER_SHOW="true"

zstyle ':omz:update' mode auto
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

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
    update_git_repo "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    update_git_repo "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    update_git_repo "$ZSH_CUSTOM/themes/spaceship-prompt"
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
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
