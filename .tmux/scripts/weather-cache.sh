#!/bin/bash
CACHE="/tmp/tmux-weather.txt"
# Refresh every 10 minutes
if [ ! -f "$CACHE" ] || [ $(( $(date +%s) - $(stat -c %Y "$CACHE") )) -gt 600 ]; then
    ~/.tmux/plugins/tmux-weather/scripts/weather.sh > "$CACHE" 2>/dev/null
fi
cat "$CACHE"
