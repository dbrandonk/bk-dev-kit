#!/bin/bash

# Fail out if a step fails.
set -euo pipefail

sudo apt update
sudo apt install -y --fix-missing \
  aspell \
  bash-completion \
  checkinstall \
  clang-tidy \
  curl \
  fd-find \
  feh \
  fish \
  git \
  htop \
  imagemagick \
  luarocks \
  man \
  pipx \
  python3-venv \
  ranger \
  silversearcher-ag \
  stow \
  sudo \
  tig \
  tldr \
  tmux \
  trash-cli \
  tree \
  universal-ctags \
  vim \
  vim-gtk3 \
  wget \
  x11-xserver-utils \
  xclip \
  yamllint

pipx install ast-grep-cli pynvim

# install rust
yes | rustup self uninstall || true
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
. "$HOME/.cargo/env"

cargo install ripgrep --features pcre2

# Install fzf.
~/.fzf/uninstall || true
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-update-rc

# Install lazygit.
sudo rm -rf /usr/local/bin/lazygit
curl -Lo /tmp/lazygit_0.57.0_Linux_x86_64.tar.gz https://github.com/jesseduffield/lazygit/releases/download/v0.57.0/lazygit_0.57.0_Linux_x86_64.tar.gz
tar -C /tmp -xf /tmp/lazygit_0.57.0_Linux_x86_64.tar.gz lazygit
sudo install /tmp/lazygit /usr/local/bin/lazygit
rm /tmp/lazygit_0.57.0_Linux_x86_64.tar.gz /tmp/lazygit

# Remove any stale nvim artifacts.
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Link configs
CONFIGS_DIR="$(dirname "$(realpath "$0")")/configs"
stow --dir="$CONFIGS_DIR" --target="$HOME" bash-extra tmux vim nvim

# Install nvim+LazyVim
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.1/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim && sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz && rm -rf nvim-linux-x86_64.tar.gz
