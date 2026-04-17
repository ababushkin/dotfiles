#!/bin/bash
# Core: Homebrew packages, shell configs, editor, mise toolchains, Claude Code.
# Run via ./install.sh (orchestrator) or directly.
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
mkdir -p ~/.zfunc
poetry completions zsh > ~/.zfunc/_poetry

# Shell config
cp .zshrc ~/.zshrc

# Neovim config (lazy.nvim auto-installs on first launch)
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/
rm -rf ~/.config/nvim/lua
cp -R lua ~/.config/nvim/
rm -f ~/.config/nvim/init.vim

# mise settings (mise itself is installed via Brewfile)
mise settings add idiomatic_version_file_enable_tools ruby || true

# Global toolchains (pinned to major; bump deliberately)
mise use -g node@22
mise use -g ruby@3.3

# fzf keybindings & shell integration (FZF_DEFAULT_COMMAND is set in .zshrc)
"$(brew --prefix)"/opt/fzf/install --all

# tmux + oh-my-tmux
[ -d ~/oh-my-tmux ] || git clone https://github.com/gpakosz/.tmux.git ~/oh-my-tmux
ln -sf ~/oh-my-tmux/.tmux.conf ~/.tmux.conf
cp .tmux.conf.local ~/.tmux.conf.local

# iTerm2: load prefs from this repo folder so edits are tracked.
# Must be set BEFORE first launch or iTerm2 will overwrite with its defaults.
ITERM_PREFS_DIR="$(pwd)"
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$ITERM_PREFS_DIR"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
# Silently write prefs back to the folder on quit (no dialog).
#   2 = "Save" (auto), 1 = "Lose changes", 0 = prompt
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile -bool true
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFileSelection -integer 2

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
