#!/bin/bash
# Called by Claude Code Stop hook - marks this tmux pane as having Claude ready
if [ -n "$TMUX_PANE" ]; then
    pane_id="${TMUX_PANE#%}"
    touch "/tmp/.claude_ready_pane_${pane_id}"
fi
