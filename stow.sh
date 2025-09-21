#!/bin/bash

stow -R -v -t ~ configs
sudo stow -R -v -t / system
