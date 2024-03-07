#!/bin/bash

source ~/scripts/kill_other_wofi.sh

p=' Poweroff'
r=' Reboot'
s='󰤄 Suspend'
l=' Lock'
h=' Exit Hyprland'

function options() {
    echo $p
    echo $r
    echo $s
    echo $l
    echo $h
}

res=$(options | wofi --dmenu -p 'Logout menu' --cache-file /dev/null)

sleep 0.6
if [ "$res" == "$p" ]; then
    poweroff
elif [ "$res" == "$r" ]; then
    reboot
elif [ "$res" == "$s" ]; then
    systemctl suspend
elif [ "$res" == "$l" ]; then
    loginctl lock-session
elif [ "$res" == "$h" ]; then
    hyprctl dispatch exit
fi
