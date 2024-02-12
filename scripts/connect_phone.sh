#!/bin/bash

MOUNT=~/mnt/phone

arp-scan -l -r 7

phone_ip=$(ip neighbor | grep "$PHONE_MAC" | cut -d " " -f1)
echo trying to connect to $phone_ip

sshfs "$phone_ip":storage $MOUNT -o follow_symlinks -p 8022
