#!/bin/bash

t=180000

value=$(pkexec /usr/bin/brillo)

if [ $1 == 'up' ]; then
    if (( $(echo "$value > 45" | bc -l) )); then
        pkexec /usr/bin/brillo -u $t -S 80
    elif (( $(echo "$value < 1.5" | bc -l) )); then
        pkexec /usr/bin/brillo -u $t -S 1.5
    else
        pkexec /usr/bin/brillo -u $t -A 5 -q
    fi
elif [ $1 == 'down' ]; then
    if (( $(echo "$value < 1" | bc -l) )); then
        pkexec /usr/bin/brillo -u $t -S 0.01
    else
        pkexec /usr/bin/brillo -u $t -U 5 -q
    fi
else
    exit 1
fi
