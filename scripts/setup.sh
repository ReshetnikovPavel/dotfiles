#1/bin/bash

# make libinput gestures work
sudo gpasswd -a $USER input
newgrp input

# create default dirs
xdg-user-dirs-update
