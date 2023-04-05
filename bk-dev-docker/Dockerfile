ARG BASE_IMAGE
# ubuntu:20.04

FROM ${BASE_IMAGE}
WORKDIR /root

ARG GIT_EMAIL

# getting apt in a happy state
RUN apt autoremove --purge
RUN apt clean 
RUN apt update
RUN apt upgrade -y

# export timezone and place timezone data /etc/timezone
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# installing packages I like
RUN apt install aspell -y 
RUN apt install checkinstall -y --fix-missing
RUN apt install clang-tidy -y
RUN apt install ctags -y
RUN apt install curl -y
RUN apt install feh -y
RUN apt install git -y
RUN apt install htop -y
RUN apt install man -y
RUN apt install mypy -y
RUN apt install pip -y
RUN apt install pylint -y
RUN apt install silversearcher-ag -y
RUN apt install stow -y
RUN apt install sudo -y
RUN apt install tig -y
RUN apt install tldr -y
RUN apt install tmux -y
RUN apt install tree -y
RUN apt install ranger -y
RUN apt install vim -y
RUN apt install vim-gtk -y
RUN apt install xclip -y
RUN apt install wget -y
RUN apt install wormhole -y
RUN apt install yamllint -y

RUN pip install autopep8

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
RUN git config --global user.name "Brandon Knape"
RUN git config --global user.email "$GIT_EMAIL"
RUN git config --global diff.tool vimdiff
RUN git config --global difftool.prompt false
RUN git config --global difftool.trustExitCode true
RUN git config --global merge.tool vimdiff
RUN git config --global mergetool.prompt false
RUN git config --global mergetool.trustExitCode true
RUN git config --global --add safe.directory '*'

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
RUN git clone https://github.com/vim/vim.git
RUN cd vim/src && make && checkinstall --pkgname vim -y
RUN rm -rf vim

# All the vim plugins.
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN vim -c ':PlugInstall' -c ':qall'
RUN mkdir -p .vim/tmp

ENTRYPOINT ["/bin/bash"]
