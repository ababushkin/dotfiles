export PATH="$HOME/.local/bin:$PATH"

# fzf: keybindings/completion + use fd so .gitignore is respected
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# mise (runtime manager)
eval "$(mise activate zsh)"

# starship prompt
eval "$(starship init zsh)"

# entire CLI completions
autoload -Uz compinit && compinit
command -v entire >/dev/null 2>&1 && source <(entire completion zsh)
