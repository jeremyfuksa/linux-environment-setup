#!/bin/bash

echo -e "\U1f9d1\U200d\U1f4bb \e[1;33mClearing the default MOTD...\e[0m"
sudo rm /etc/motd
sudo touch /etc/motd

echo -e "\U1f9d1\U200d\U1f4bb \e[1;33mPreparing for initial setup...\e[0m"
sudo apt update
sudo apt install -y git zsh bc

echo -e "\U1f9d1\U200d\U1f4bb \e[1;33mInstalling oh-my-zsh...\e[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo -e "\U1f9d1\U200d\U1f4bb \e[1;33mCustomizing .zshrc...\e[0m"
rm ~/.zshrc
curl -o ~/.zshrc https://raw.githubusercontent.com/jeremyfuksa/standard-pi-setup/main/zshrc?token=AAFRKT657KNSCMHICUOOL3TBTAKYS
source ~/.zshrc

echo -e "\U1f9d1\U200d\U1f4bb \e[1;33mInstalling .zprofile...\e[0m"
curl -o ~/.zprofile https://raw.githubusercontent.com/jeremyfuksa/standard-pi-setup/main/zprofile?token=AAFRKT6WQLIURHAW5IHONT3BTAKUE
source ~/.zprofile

echo -e "\U1f9d1\U200d\U1f4bb \e[1;33mConfiguring git...\e[0m"
git config --global pull.rebase false

echo -e "\U1f9d1\U200d\U1f4bb \e[1;33mGetting the latest OS updates...\e[0m"
update-all

echo -e "\n\U1f967 \e[1;32mThis Pi is sliced! \e[0m"
