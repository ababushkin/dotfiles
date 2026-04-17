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
| `install-core.sh`   | Brewfile, zsh config + plugins, nvim, mise (node/ruby), tmux, iTerm2, Claude |
| `install-macos.sh`  | Keyboard repeat defaults, Caps Lock → Ctrl (hidutil agent)    |
| `install-git.sh`    | git identity (prompts), url rewrite, `gh auth setup-git`      |

## Manual steps (not automated)

These are interactive or need a reboot/logout — do them after `./install.sh`.

1. **GitHub auth** — `gh auth login` (then re-run `./install-git.sh` so
   `gh auth setup-git` wires gh as the git credential helper).
2. **Log out and back in** so keyboard repeat settings take effect in every
   app (some apps cache the values at launch).

## iTerm2 prefs

`install-core.sh` points iTerm2 at this repo via `PrefsCustomFolder`, so
`com.googlecode.iterm2.plist` in the repo is the source of truth. Changes
you make in the iTerm2 GUI are written back to the plist automatically on
quit — just `git diff` and commit.

To verify after first launch:

- iTerm2 → Settings → General → Preferences:
  - "Load preferences from a custom folder or URL" is checked,
    pointing at `~/src/dotfiles`.
  - Below it, "Save changes to folder when iTerm2 quits" is selected
    (rather than "Never" or "Ask").

To export manually at any time:

```bash
defaults export com.googlecode.iterm2 ~/src/dotfiles/com.googlecode.iterm2.plist
```

Scrollback lives in tmux (`history-limit 50000`), not iTerm2 — keep the
iTerm2 profile's scrollback small to avoid two layers of history.
