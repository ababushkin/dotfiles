#!/bin/bash
# git + GitHub CLI configuration.
# Personal identity (user.name/user.email) is prompted, never committed to repo.
# gh auth login itself is interactive and stays a manual step (see README).
set -euo pipefail

# -- identity (prompt once, skip if already set) -------------------------------
if ! git config --global --get user.name >/dev/null; then
  read -rp "git user.name: " name
  git config --global user.name "$name"
fi

if ! git config --global --get user.email >/dev/null; then
  read -rp "git user.email: " email
  git config --global user.email "$email"
fi

# -- non-personal preferences --------------------------------------------------
# Rewrite SSH-style GitHub URLs to HTTPS so the gh credential helper handles auth.
git config --global url."https://github.com/".insteadOf "git@github.com:"

# -- gh as git credential helper (only if already authed) ----------------------
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  gh auth setup-git
else
  echo "gh not authed — run 'gh auth login' then re-run this script." >&2
fi
