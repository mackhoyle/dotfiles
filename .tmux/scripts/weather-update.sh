#!/bin/bash
CACHE="/tmp/tmux-weather.txt"
# Refresh cache every 10 minutes
if [ ! -f "$CACHE" ] || [ $(( $(date +%s) - $(stat -c %Y "$CACHE") )) -gt 600 ]; then
    ~/.tmux/plugins/tmux-weather/scripts/weather.sh | sed 's/^[^ ]* //' > "$CACHE" 2>/dev/null
fi
WEATHER=$(cat "$CACHE")
tmux set -g @weather "#[fg=#f9e2af]$WEATHER"
