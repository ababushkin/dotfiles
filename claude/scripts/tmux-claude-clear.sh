#!/bin/bash
# Clear the Claude ready indicator for a tmux session.
# Accepts optional session name as $1; otherwise uses the current session.
SESSION="${1:-$(tmux display-message -p '#S' 2>/dev/null)}"
if [ -n "$SESSION" ]; then
    SAFE_NAME="${SESSION// /_}"
    rm -f "/tmp/.claude_ready_${SAFE_NAME}"
fi
