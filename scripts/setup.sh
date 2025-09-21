#1/bin/bash

# make libinput gestures work
sudo gpasswd -a $USER input
newgrp input

# docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# create default dirs
xdg-user-dirs-update
