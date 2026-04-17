# Sourced by every zsh invocation (interactive, non-interactive, login).
# Keep this file minimal — things that must be in env for scripts and
# tool-spawned shells (e.g. Claude Code's `zsh -c -l`).

# Ensure mise + brew are on PATH for non-login shells (scripts, subshells)
# where /etc/zprofile's path_helper hasn't run yet.
export PATH="/opt/homebrew/bin:$HOME/.local/bin:$PATH"

# mise shims. Login shells get this re-applied in ~/.zprofile after macOS
# path_helper runs in /etc/zprofile and wipes earlier PATH edits.
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh --shims)"
