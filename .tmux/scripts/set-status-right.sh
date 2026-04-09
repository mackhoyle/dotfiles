#!/bin/bash
WEATHER=$(~/.tmux/scripts/weather-cache.sh 2>/dev/null) || true
tmux set -q -g @weather_display "${WEATHER}"
exit 0
