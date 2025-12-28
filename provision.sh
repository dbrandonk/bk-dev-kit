#!/bin/bash

# Fail out if a step fails.
set -eu

sudo apt update
sudo apt install -y --fix-missing \
aspell \
bash-completion \
checkinstall \
clang-tidy \
universal-ctags \
curl \
feh \
git \
htop \
man \
python3-venv \
stow \
sudo \
tig \
tldr \
tmux \
tree \
ranger \
ripgrep \
vim \
vim-gtk3 \
x11-xserver-utils \
xclip \
wget \
yamllint

# fixing install of fzf if there is an issue
~/.fzf/uninstall || true
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-update-rc
