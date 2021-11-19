#!/bin/bash

echo "Clearing the default MOTD..."
sudo rm /etc/motd
sudo touch /etc/motd

echo "Preparing for initial setup..."
sudo apt update
sudo apt install -y git zsh bc

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "Customizing .zshrc..."
rm ~/.zshrc
curl -o ~/.zshrc https://raw.githubusercontent.com/jeremyfuksa/standard-pi-setup/main/zshrc?token=AAFRKT657KNSCMHICUOOL3TBTAKYS
source ~/.zshrc

echo "Installing .zprofile..."
curl -o ~/.zprofile https://raw.githubusercontent.com/jeremyfuksa/standard-pi-setup/main/zprofile?token=AAFRKT6WQLIURHAW5IHONT3BTAKUE
source ~/.zprofile

echo "Configuring git..."
git config --global pull.rebase false

echo "Getting the latest OS updates..."
update-all

echo ""
echo "This Pi is sliced!"
