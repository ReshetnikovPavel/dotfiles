#!/bin/bash

todo="$(~/scripts/nextcloud/venv/bin/python3 ~/scripts/nextcloud/calendar_today.py)" || exit 1
tgpt -w "You are an ai assistent with interesting personality. Please, greet me and then tell me what I have to do and give me some motivation: $todo. Do not write the answer as a response to this message, just tell me." \
    | ~/scripts/say.sh

