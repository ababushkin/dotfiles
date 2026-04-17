#!/bin/bash
# Orchestrator: runs every install-*.sh in order, with sudo primed upfront
# so there's no mid-run password prompt.
# Run individual stages directly if you want to re-run just one.
set -euo pipefail

cd "$(dirname "$0")"

# Cache sudo credentials up front (Java symlink in install-core.sh needs them)
sudo -v

# Keep sudo alive for the duration of this script
while true; do sudo -n true; sleep 50; kill -0 "$$" || exit; done 2>/dev/null &
SUDO_KEEPALIVE=$!
trap 'kill "$SUDO_KEEPALIVE" 2>/dev/null || true' EXIT

./install-core.sh
./install-macos.sh
./install-git.sh

# -- verify --------------------------------------------------------------------
echo
echo "-- verification --"
for bin in brew mise fish fzf nvim tmux gh rtk claude; do
  if command -v "$bin" >/dev/null 2>&1; then
    printf "  %-8s %s\n" "$bin" "$("$bin" --version 2>&1 | head -n1)"
  else
    printf "  %-8s MISSING\n" "$bin"
  fi
done

echo
echo "Done. See README for remaining manual steps."
