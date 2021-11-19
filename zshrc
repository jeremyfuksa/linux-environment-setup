# Path to your oh-my-zsh installation.
export ZSH="/home/pi/.oh-my-zsh"

ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ADD_NEWLINE="true"
SPACESHIP_CHAR_SYMBOL=" ➜ "
SPACESHIP_CHAR_PREFIX="\ue709"
SPACESHIP_CHAR_SUFFIX=(" ")
SPACESHIP_CHAR_COLOR_SUCCESS="green"
SPACESHIP_PROMPT_DEFAULT_PREFIX="$USER"
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="true"
SPACESHIP_USER_SHOW="true"

zstyle ':omz:update' mode auto      # update automatically without asking

# Which plugins would you like to load?
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias xoff='sudo /usr/local/bin/x-c1-softsd.sh'

function update-all() {
  (
    echo -e "\U1f9d1\U200d\U1f4bb \e[1;33mPulling the latest git updates...\e[0m"
    echo -e "\U2139 Pulling zsh-syntax-highlighting..."
    cd $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    git pull origin
    echo -e "\U2139 Pulling zsh-autosuggestions..."
    cd $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git pull origin
    echo -e "\U2139 Pulling spaceship-prompt..."
    cd $ZSH_CUSTOM/themes/spaceship-prompt
    git pull origin
    cd ~/
    echo -e "\U1f9d1\U200d\U1f4bb \e[1;33mGetting the latest OS updates...\e[0m"
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt autoremove -y
    echo -e "\U1f984\e[1;35m HOT UNICORNS NOW! \e[0m"
  )
}

function install() {
  (sudo apt install -y $*)
}

bindkey '[C' forward-word
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
