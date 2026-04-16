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

# Install/setup for ruby/rails development
curl https://mise.run | sh
brew install libyaml # https://stackoverflow.com/questions/78817340/mise-cannot-install-ruby3-2-1-on-mac-m3
mise settings add idiomatic_version_file_enable_tools ruby
eval "$(mise activate bash)"
eval "$(mise activate zsh)"
mise activate fish | source

# Install fish and fisher
brew install fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Fish plugins
fisher install jorgebucaran/nvm.fish
fisher install jethrokuan/z

# Install Oh-My-Fish (omf)
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# Install fisher theme
omf install clearance
omf reload
omf theme clearance

# Install and configure fzf
brew install fzf
$(brew --prefix)/opt/fzf/install

# Install tmux + oh-my-tmux
brew install tmux
git clone https://github.com/gpakosz/.tmux.git ~/oh-my-tmux
ln -s -f ~/oh-my-tmux/.tmux.conf ~/.tmux.conf
cp .tmux.conf.local ~/.tmux.conf.local

# Install alacritty
brew install --cask alacritty
mkdir -p ~/.config/alacritty
cp alacritty.toml ~/.config/alacritty/

# Fonts
brew install --cask font-fira-code

# Java
brew install openjdk

# Docker
brew install --cask docker

# 1password
brew install --cask 1password

# VLC
brew install --cask vlc

# Install Claude Code tmux notification scripts
mkdir -p ~/.claude/scripts
cp claude/scripts/tmux-claude-notify.sh ~/.claude/scripts/
cp claude/scripts/tmux-claude-clear.sh ~/.claude/scripts/
chmod +x ~/.claude/scripts/tmux-claude-notify.sh ~/.claude/scripts/tmux-claude-clear.sh

# Add Claude Code Stop hook to ~/.claude/settings.json (creates file if missing)
python3 - <<'PYEOF'
import json, os

path = os.path.expanduser("~/.claude/settings.json")
settings = {}
if os.path.exists(path):
    with open(path) as f:
        settings = json.load(f)

hook = {"type": "command", "command": "bash ~/.claude/scripts/tmux-claude-notify.sh"}
stop_hooks = settings.setdefault("hooks", {}).setdefault("Stop", [])

# Only add if not already present
if not any(h.get("hooks", []) == [hook] for h in stop_hooks):
    stop_hooks.append({"hooks": [hook]})

with open(path, "w") as f:
    json.dump(settings, f, indent=2)
    f.write("\n")

print("Claude settings.json updated with tmux Stop hook")
PYEOF
