# Sourced by every zsh invocation (interactive, non-interactive, login).
# Keep this file minimal — things that must be in env for scripts and
# tool-spawned shells (e.g. Claude Code's `zsh -c -l`).

# mise shims for non-login shells (scripts, subshells).
# Login shells get this re-applied in ~/.zprofile after macOS path_helper
# runs in /etc/zprofile and wipes earlier PATH edits.
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh --shims)"
