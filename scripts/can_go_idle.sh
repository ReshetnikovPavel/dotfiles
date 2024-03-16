#!/bin/bash


outputs=$(pacmd list-sink-inputs | grep state | grep RUNNING)

if [ -n "$outputs" ]; then
    exit 1
fi

inputs=$(pacmd list-source-outputs | grep state | grep RUNNING)

if [ -n "$inputs" ]; then
    exit 1
fi

exit 0

