# dotfiles

## Install

```bash
# 1. Homebrew (also pulls in Xcode CLT)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Everything else
./install.sh
```

`install.sh` is an orchestrator that runs each stage in order. Re-run individual
stages directly when you only want to change one thing:

| Stage               | What it does                                                  |
| ------------------- | ------------------------------------------------------------- |
| `install-core.sh`   | Brewfile, zsh config + plugins, nvim, mise (node/ruby), tmux, Claude |
| `install-macos.sh`  | Keyboard repeat defaults, Caps Lock → Ctrl (hidutil agent)    |
| `install-git.sh`    | git identity (prompts), url rewrite, `gh auth setup-git`      |

## Manual steps (not automated)

These are interactive or need a reboot/logout — do them after `./install.sh`.

1. **GitHub auth** — `gh auth login` (then re-run `./install-git.sh` so
   `gh auth setup-git` wires gh as the git credential helper).
2. **Log out and back in** so keyboard repeat settings take effect in every
   app (some apps cache the values at launch).
