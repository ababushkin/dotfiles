#!/bin/bash

brew update
brew upgrade

brew install git
brew install rg
brew install fd # we'll use FD for FZF to support .gitignore easily

# Install and setup environment for Python development
## Install PIPX and Poetry https://github.com/pypa/pipx
brew install pipx
pipx ensurepath
sudo pipx ensurepath --global # optional to allow pipx actions with --global argument
# https://python-poetry.org/docs/#installing-with-pipx
pipx install poetry
poetry completions fish > ~/.config/fish/completions/poetry.fish


# Install node and setup environment for JS development
brew install node
brew install nvm
## Install neovim, vim plug and deoplete dependencies
brew install nvim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install --user pynvim

# Install fish and fisher
brew install fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Fish plugins
fisher install jorgebucaran/nvm.fish
fisher install jethrokuan/z

# Install Oh-My-Fish (omf)
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# Install fisher theme
omf install oh-my-theme/theme-clearance

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
cp alacritty.yml ~/.config/alacritty/

# Install visual studio code
brew install --cask visual-studio-code
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false # Make repeat keystrokes work in VIM mode

# Fonts
brew tap homebrew/cask-fonts
brew install font-fira-code

# Java
brew install openjdk

# Useful apps
brew install --cask google-chrome
brew install --cask 1password

