#!/bin/bash

if [[ $1 == n ]]; then
    echo $(playerctl -l | tail -n 1)
elif [[ $1 == p ]]; then
    echo $(playerctl -l | head -n 2 | tail -n 1)
fi
