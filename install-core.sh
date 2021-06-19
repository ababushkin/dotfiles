#!/bin/bash

brew update
brew upgrade

brew install git
brew install fish
brew install rg

# Install and configure fzf
brew install fzf
$(brew --prefix)/opt/fzf/install

# Install tmux + oh-my-tmux
brew install tmux
git clone https://github.com/gpakosz/.tmux.git ~/oh-my-tmux
ln -s -f ~/oh-my-tmux/.tmux.conf ~/.tmux.conf
cp ~/oh-my-tmux/.tmux.conf.local ~/.tmux.conf.local

brew install --cask alacritty
mkdir -p ~/.config/alacritty
cp .alacritty.yml ~/.config/alacritty/ 
