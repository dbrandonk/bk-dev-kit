#!/bin/bash

# Fail out if a step fails.
set -euo pipefail

sudo apt update
sudo apt install -y --fix-missing \
  aspell \
  bash-completion \
  checkinstall \
  clang-tidy \
  universal-ctags \
  curl \
  feh \
  fd-find \
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
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim && sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz && rm -rf nvim-linux-x86_64.tar.gz

# Install LazyVim
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
