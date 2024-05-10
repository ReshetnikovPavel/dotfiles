#!/bin/bash

source ~/scripts/kill_other_wofi.sh
IDLE='hypridle'

p=' Poweroff'
r=' Reboot'
s1=' Suspend then Hibernate'
s2='󰤄 Suspend'
h1=' Hibernate'
l=' Lock'
kh='󰒳 Kill Hypridle'
eh='󰒲 Enable Hypridle'
h=' Exit Hyprland'

function options() {
    echo "$p"
    echo "$r"
    echo "$s1"
    echo "$s2"
    echo "$h1"
    echo "$l"
    
    if pgrep -x "$IDLE" > /dev/null; then
        echo "$kh"
    else
        echo "$eh"
    fi

    echo "$h"
}

res=$(options | wofi --dmenu -p 'Logout menu' --cache-file /dev/null)

sleep 0.6
if [ "$res" == "$p" ]; then
    poweroff
elif [ "$res" == "$r" ]; then
    reboot
elif [ "$res" == "$s1" ]; then
    systemctl suspend-then-hibernate
elif [ "$res" == "$s2" ]; then
    systemctl suspend
elif [ "$res" == "$h1" ]; then
    systemctl hibernate
elif [ "$res" == "$l" ]; then
    if pgrep -x "$IDLE"; then
        loginctl lock-session
    else
        ~/scripts/swaylock.sh
    fi
elif [ "$res" == "$kh" ]; then
    pkill "$IDLE"
elif [ "$res" == "$eh" ]; then
    hyprctl dispatch exec "$IDLE"
elif [ "$res" == "$h" ]; then
    hyprctl dispatch exit
fi
