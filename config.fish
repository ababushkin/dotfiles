set -x EDITOR nvim
set -x TERM screen-256color
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x PATH $PATH ~/Library/Python/3.9/bin
set -x FZF_DEFAULT_COMMAND fd --type f
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

alias vim nvim
