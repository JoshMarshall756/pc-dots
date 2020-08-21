#!/usr/bin/env bash

# terminate already running bar instances
killall -q polybar 

# -u $UID
# wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# find all monitors and launch all bars on them monitors
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar -l info -c ~/.config/polybar/config main &
		MONITOR=$m polybar -l info -c ~/.config/polybar/config second &
	done
else
	polybar --reload ~/.config/polybar/config main &
	polybar --reload ~/.config/polybar/config second &
fi

echo "Bars launched..."
