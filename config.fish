set -x EDITOR nvim
set -x TERM screen-256color
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

# fzf: use fd so .gitignore is respected and hidden files included
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# mise (runtime manager)
mise activate fish | source

# starship prompt
starship init fish | source

alias vim nvim
