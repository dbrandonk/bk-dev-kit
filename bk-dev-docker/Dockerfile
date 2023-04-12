ARG BASE_IMAGE
# ubuntu:20.04

FROM ${BASE_IMAGE}
WORKDIR /root

ARG GIT_EMAIL

# getting apt in a happy state
RUN apt autoremove --purge \
&& apt clean \
&& apt update \
&& apt upgrade -y

# export timezone and place timezone data /etc/timezone
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# installing packages I like
RUN apt install aspell -y \
&& apt install checkinstall -y --fix-missing \
&& apt install clang-tidy -y \
&& apt install ctags -y \
&& apt install curl -y \
&& apt install feh -y \
&& apt install git -y \
&& apt install htop -y \
&& apt install man -y \
&& apt install mypy -y \
&& apt install pip -y \
&& apt install pylint -y \
&& apt install silversearcher-ag -y \
&& apt install stow -y \
&& apt install sudo -y \
&& apt install tig -y \
&& apt install tldr -y \
&& apt install tmux -y \
&& apt install tree -y \
&& apt install ranger -y \
&& apt install vim -y \
&& apt install vim-gtk3 -y \
&& apt install xclip -y \
&& apt install wget -y \
&& apt install wormhole -y \
&& apt install yamllint -y

RUN pip install autopep8 \
&& pip install ipython3 \
&& pip install monkeytype \

# fixing install of fzf if there is an issue
RUN ./.fzf/uninstall || true
RUN rm -rf ./.fzf
RUN apt install fzf -y

# installing google chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN DEBIAN_FRONTEND=noninteractive apt install ./google-chrome*.deb -y
RUN rm -rf ./google-chrome*.deb

# unminimize the docker
RUN yes | unminimize || true

# git config
RUN git config --global user.name "Brandon Knape" \
&& git config --global user.email "$GIT_EMAIL" \
&& git config --global diff.tool vimdiff \
&& git config --global difftool.prompt false \
&& git config --global difftool.trustExitCode true \
&& git config --global merge.tool vimdiff \
&& git config --global mergetool.prompt false \
&& git config --global mergetool.trustExitCode true \
&& git config --global --add safe.directory '*'

# doing whole bunch of dot file stuff.
RUN git clone https://github.com/dbrandonk/.dotfiles
RUN mv .dotfiles/.bashrc-extra .bashrc-extra
# Doing some hacky writing to the .bashrc
RUN echo '. $HOME/.bashrc-extra' >> .bashrc
# This is a real hacky solution so tmux start when the container starts without it in the entrypoint call because that breaks the vim coloring for some reason
RUN echo 'export TERM=xterm-256color' >> .bashrc
RUN echo 'if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then' >> .bashrc
RUN echo 'exec tmux' >> .bashrc
RUN echo 'fi' >> .bashrc
# making the prompt pretty. ;)
RUN rm -rf ~/.bash-git-prompt # remove this if it exists for some reason.
RUN git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
run echo 'source $HOME/.bash-git-prompt/gitprompt.sh' >> .bashrc
RUN apt-get install locales -y
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
# tmux and vim config files
RUN mv .dotfiles/.tmux.conf .tmux.conf
RUN mv .dotfiles/.vimrc .vimrc
RUN rm .dotfiles -rf

# getting my ssh file from my host machine.
RUN rm .ssh -rf
ADD .ssh .ssh

# getting latest version of vim
# RUN git clone https://github.com/vim/vim.git
# RUN cd vim/src && make && checkinstall --pkgname vim -y
# RUN rm -rf vim

# All the vim plugins.
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN vim -c ':PlugInstall' -c ':qall'
RUN mkdir -p .vim/tmp

ENTRYPOINT ["/bin/bash"]
