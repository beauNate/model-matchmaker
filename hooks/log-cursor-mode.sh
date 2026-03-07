#!/bin/bash
# Log Current Cursor Mode
# Usage: ./log-cursor-mode.sh [plan|agent|debug|ask]
# Creates a state file that auto-switch-model.sh reads to adjust dropdown positions.

MODE="${1:-agent}"
STATE_FILE="$HOME/.cursor/hooks/.cursor-mode"

case "$MODE" in
    plan|agent|debug|ask)
        echo "$MODE" > "$STATE_FILE"
        echo "Mode set to: $MODE"
        echo "Auto-switch will now use the correct dropdown positions for $MODE mode."
        ;;
    *)
        echo "Invalid mode. Use: plan, agent, debug, or ask"
        exit 1
        ;;
esac
