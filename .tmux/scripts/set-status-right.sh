#!/bin/bash
WEATHER=$(~/.tmux/scripts/weather-cache.sh)
tmux set -g @weather_display "${WEATHER}"
