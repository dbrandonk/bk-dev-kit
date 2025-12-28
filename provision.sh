#!/bin/bash

sudo apt update
sudo apt install $(cat bk-dev-docker/apt_packages.txt) -y --fix-missing

# fixing install of fzf if there is an issue
~/.fzf/uninstall || true
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-update-rc

# one day I should do gsettings stuff here.
