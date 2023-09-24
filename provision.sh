#!/bin/bash

sudo apt update
sudo apt install $(cat bk-dev-docker/apt_packages.txt) -y --fix-missing

# one day I should do gsettings stuff here.
