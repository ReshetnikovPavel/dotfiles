#!/bin/bash


mimic3 --voice en_US/cmu-arctic_low#eey "$@" | mpv - --no-input-default-bindings --no-config
