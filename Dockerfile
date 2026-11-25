ARG BASE_IMAGE=ubuntu:22.04

FROM ${BASE_IMAGE}
WORKDIR /root

ARG DEBIAN_FRONTEND=noninteractive

# getting apt in a happy state
RUN apt autoremove --purge \
&& apt clean \
&& apt update -y

RUN apt install -y sudo

# Run provisioning script
COPY provision.sh /root/.bk-dev-kit/provision.sh
COPY configs /root/.bk-dev-kit/configs
RUN bash /root/.bk-dev-kit/provision.sh

# Tree-sitter binary for nvim. Need to do this b/c its broken for ubuntu 22.04.
RUN wget -qO- https://github.com/tree-sitter/tree-sitter/releases/download/v0.25.10/tree-sitter-linux-x64.gz \
  | gunzip > /usr/local/bin/tree-sitter \
&& chmod +x /usr/local/bin/tree-sitter

# installing firefox
RUN apt install -y software-properties-common \
&& add-apt-repository -y ppa:mozillateam/ppa \
&& printf 'Package: *\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1001\n' > /etc/apt/preferences.d/mozilla-firefox \
&& apt install -y firefox

# installing opencode
RUN curl -fsSL https://opencode.ai/install | bash

# unminimize the docker
# RUN yes | unminimize || true

RUN git config --system --add safe.directory '*'

# making the prompt pretty. ;)
RUN rm -rf ~/.bash-git-prompt \
&& git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
RUN apt-get install locales -y \
&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG=en_US.utf8

# Hook .bashrc-extra, auto-start tmux, and the git prompt into the .bashrc.
RUN { \
  echo '. $HOME/.bashrc-extra'; \
  echo 'if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then'; \
  echo 'exec tmux'; \
  echo 'fi'; \
  echo 'source $HOME/.bash-git-prompt/gitprompt.sh'; \
} >> .bashrc

# All the vim plugins.
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
&& vim -c ':PlugInstall' -c ':qall' \
&& mkdir -p .vim/tmp

CMD ["/bin/bash"]
