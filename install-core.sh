#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

# pipx and mise install into ~/.local/bin; make sure it's on PATH for this script
export PATH="$HOME/.local/bin:$PATH"

# Homebrew packages (see Brewfile)
brew update
brew bundle --file=Brewfile

# Python tooling
pipx ensurepath
pipx list --short 2>/dev/null | grep -q '^poetry ' || pipx install poetry
mkdir -p ~/.config/fish/completions
poetry completions fish > ~/.config/fish/completions/poetry.fish

# Shell configs
mkdir -p ~/.config/fish
cp config.fish ~/.config/fish/config.fish
cp .zshrc ~/.zshrc

# Neovim config (lazy.nvim auto-installs on first launch)
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/
rm -rf ~/.config/nvim/lua
cp -R lua ~/.config/nvim/
rm -f ~/.config/nvim/init.vim

# mise settings (mise itself is installed via Brewfile)
mise settings add idiomatic_version_file_enable_tools ruby || true
# mise activation is configured in config.fish / .zshrc — open a new shell,
# then install toolchains as needed, e.g.: mise use -g node@lts ruby@3.3

# Fisher + fish plugins (plugin set is managed via fish_plugins in this repo)
if ! fish -c 'functions -q fisher' >/dev/null 2>&1; then
  fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; and fisher install jorgebucaran/fisher'
fi
cp fish_plugins ~/.config/fish/fish_plugins
fish -c 'fisher update'

# fzf keybindings & shell integration (FZF_DEFAULT_COMMAND is set in config.fish / .zshrc)
"$(brew --prefix)"/opt/fzf/install --all

# tmux + oh-my-tmux
[ -d ~/oh-my-tmux ] || git clone https://github.com/gpakosz/.tmux.git ~/oh-my-tmux
ln -sf ~/oh-my-tmux/.tmux.conf ~/.tmux.conf
[ -f ~/.tmux.conf.local ] || cp .tmux.conf.local ~/.tmux.conf.local

# Java: link openjdk into the system JVM path
if [ ! -e /Library/Java/JavaVirtualMachines/openjdk.jdk ]; then
  sudo ln -sfn "$(brew --prefix)/opt/openjdk/libexec/openjdk.jdk" \
    /Library/Java/JavaVirtualMachines/openjdk.jdk
fi

# Claude Code CLI
if ! command -v claude >/dev/null 2>&1; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

# rtk (LLM output filter) — registers its own PreToolUse hook in ~/.claude/settings.json
rtk init -g || true

# Plugin marketplaces + installed plugins
claude plugin marketplace add JuliusBrussee/caveman || true
claude plugin install caveman@caveman || true
claude plugin marketplace add addyosmani/agent-skills || true
claude plugin install agent-skills@addy-agent-skills || true

# Global Claude Code user settings (permissions + env) — only install if missing
mkdir -p ~/.claude
[ -f ~/.claude/settings.local.json ] || cp claude/settings.local.json ~/.claude/settings.local.json
