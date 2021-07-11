#!/bin/bash

brew update
brew upgrade

brew install git
brew install rg

# Install node
brew install node
brew install nvm

# Install neovim, vim plug and deoplete dependencies
brew install nvim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install --user pynvim

# Install fish and fisher
brew install fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# Fish plugins
fisher install jorgebucaran/nvm.fish
fisher install jethrokuan/z

# Install and configure fzf
brew install fzf
$(brew --prefix)/opt/fzf/install

# Install tmux + oh-my-tmux
brew install tmux
git clone https://github.com/gpakosz/.tmux.git ~/oh-my-tmux
ln -s -f ~/oh-my-tmux/.tmux.conf ~/.tmux.conf
cp ~/oh-my-tmux/.tmux.conf.local ~/.tmux.conf.local

# Install alacritty
brew install --cask alacritty
mkdir -p ~/.config/alacritty
cp .alacritty.yml ~/.config/alacritty/ 

# Install visual studio code
brew install --cask visual-studio-code
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false # Make repeat keystrokes work in VIM mode

# Java
brew install --cask adoptopenjdk
