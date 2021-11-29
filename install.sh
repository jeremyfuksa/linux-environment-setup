#!/bin/bash

echo -e "\U1f9d1\U200d\U1f4bb \e[1;33mClearing the default MOTD...\e[0m"
sudo rm /etc/motd
sudo touch /etc/motd

echo -e "\U1f9d1\U200d\U1f4bb \e[1;33mPreparing for initial setup...\e[0m"
sudo apt update
sudo apt install -y git zsh bc

echo -e "\U1f9d1\U200d\U1f4bb \e[1;33mInstalling oh-my-zsh...\e[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
