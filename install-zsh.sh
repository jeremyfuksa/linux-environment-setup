#!/bin/bash

# Install prerequisites
sudo apt update && sudo apt upgrade
sudo apt install -y zsh git bc

# Install and enable Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
