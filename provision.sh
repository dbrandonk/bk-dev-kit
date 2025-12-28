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

# Install fzf.
~/.fzf/uninstall || true
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-update-rc

# Install nvim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
RUN rm -rf /opt/nvim && tar -C /opt -xzf nvim-linux-x86_64.tar.gz && rm -rf nvim-linux-x86_64.tar.gz
