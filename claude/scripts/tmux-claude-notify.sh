#!/bin/bash
# Called by Claude Code Stop hook - marks this tmux session as having Claude ready
if [ -n "$TMUX" ]; then
    SESSION=$(tmux display-message -p '#S' 2>/dev/null)
    if [ -n "$SESSION" ]; then
        SAFE_NAME="${SESSION// /_}"
        touch "/tmp/.claude_ready_${SAFE_NAME}"
    fi
fi
