#!/bin/bash
# Clear the Claude ready indicator for a tmux pane.
# Accepts optional pane ID as $1; otherwise uses the active pane.
pane_id="${1:-$(tmux display-message -p '#{pane_id}' 2>/dev/null)}"
pane_id="${pane_id#%}"
if [ -n "$pane_id" ]; then
    rm -f "/tmp/.claude_ready_pane_${pane_id}"
fi
