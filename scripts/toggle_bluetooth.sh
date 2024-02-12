#!/bin/bash


enabled=$(bluetoothctl show | grep -E 'Powered: ' | sed -r 's/.*Powered: (.*)/\1/')

if [ "$enabled" == 'yes' ]; then
    bluetoothctl power off
else
    bluetoothctl power on
fi
