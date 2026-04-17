export PATH="$HOME/.local/bin:$PATH"

# fzf: keybindings/completion + use fd so .gitignore is respected
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# mise (runtime manager)
eval "$(mise activate zsh)"

# starship prompt
eval "$(starship init zsh)"

# ~/.zfunc holds personal completions (e.g. poetry); must be in fpath before compinit
fpath=(~/.zfunc $fpath)

# completions
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive match

# history (shared across sessions, dedup consecutive dupes)
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY

# entire CLI completions
command -v entire >/dev/null 2>&1 && source <(entire completion zsh)

# zoxide (smarter cd: z <dir>, zi for interactive)
eval "$(zoxide init zsh)"

# zsh plugins (order matters: syntax-highlight → history-substring → autosuggest)
BREW_PREFIX="$(brew --prefix)"
[ -f "$BREW_PREFIX/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ] \
  && source "$BREW_PREFIX/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
[ -f "$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ] \
  && source "$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] \
  && source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# ↑/↓ walk history filtered by what's typed so far
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

alias vim=nvim
