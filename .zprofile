# Sourced for login shells (after /etc/zprofile, which runs path_helper
# and wipes any PATH prepends from ~/.zshenv).
# Put anything that must survive path_helper here — brew, pipx, mise shims.

eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# pipx user bin
export PATH="$PATH:$HOME/.local/bin"

# mise shims — Claude Code's Bash tool invokes `zsh -c -l`, which is a
# non-interactive login shell. Without this, plain `ruby`/`bundle`/etc.
# fall through to /usr/bin system versions instead of the project's
# mise-managed toolchain.
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh --shims)"
