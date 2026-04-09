#!/bin/bash
WEATHER=$(~/.tmux/scripts/weather-cache.sh)
tmux set -q -g @weather_display "${WEATHER}"
