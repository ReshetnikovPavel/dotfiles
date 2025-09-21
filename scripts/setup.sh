#1/bin/bash

# make libinput gestures work
sudo gpasswd -a $USER input
newgrp input
