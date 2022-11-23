#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar main -c $HOME/.config/polybar/config.ini &
# Launch polybar
# polybar main -c $(dirname $0)/config.ini &

# if [[ $(xrandr -q | grep 'DP1 connected') ]]; then
	# polybar external -c $(dirname $0)/config.ini &
# fi
