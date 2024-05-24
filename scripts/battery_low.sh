#!/bin/sh

while true; do
    percent=$(acpi -b | grep -P -o '[0-9]+(?=%)')
    if [[ $(acpi -a) == *'off-line'* ]]; then
        if [ $percent -le 5 ]; then
            notify-send --urgency=critical "Connect power. Now."
        elif [ $percent -le 15 ]; then
            notify-send --urgency=critical "Battery is very low: ${percent}% left. Please, I need some electricity to live longer"
        elif [ $percent -le 40 ]; then
            notify-send "Battery: ${percent}% left. You might want to consider connecting me to the power source"
        fi
    elif [ $percent -ge 100 ]; then
            notify-send --urgency=critical "BATTERY IS FULL. UNPLUG IT."
        elif [ $percent -ge 90 ]; then 
            notify-send  --urgency=critical "Battery: ${percent}%. Do you want to make the battery useless in a few months? DISCONNECT ME FROM POWER"
        elif [ $percent -ge 80 ]; then
            notify-send --urgency=critical "Battery: ${percent}%. This is the best time to unplug me from the power. Or else."
        elif [ $percent -ge 60 ]; then
            notify-send "Battery: ${percent}%. If you want my battery to function properly for a long time, unplug the laptop"
        fi
    sleep 2m
done
