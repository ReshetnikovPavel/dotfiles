#!/bin/bash


if pactl list short sinks | grep RUNNING; then
	exit 1
fi


activewindowclass=$(hyprctl activewindow -j | jq .class)
if [ "$activewindowclass" == '"com.github.johnfactotum.Foliate"' ]; then
	exit 1
fi


if pgrep yay || pgrep pacman; then
	exit 1
fi

exit 0

