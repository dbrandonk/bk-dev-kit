ARG BASE_IMAGE

FROM ${BASE_IMAGE}
WORKDIR ..

ARG GIT_EMAIL

RUN apt update && apt upgrade -y
RUN apt install \
checkinstall \
clang-tidy \
ctags \
htop \
python3-colcon-argcomplete \
silversearcher-ag \
xclip \
yamllint \
--fix-missing -y

# fixing install of fzf
RUN ./.fzf/uninstall
RUN rm -rf ./.fzf
RUN apt install fzf -y

# installing google chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt install ./google-chrome*.deb -y
RUN rm -rf ./google-chrome*.deb

# unminimize the docker
RUN yes| unminimize

RUN git config --global user.name "Brandon Knape"
RUN git config --global user.email "$GIT_EMAIL"
RUN git config --global diff.tool vimdiff
RUN git config --global difftool.prompt false
RUN git config --global difftool.trustExitCode true
RUN git config --global merge.tool vimdiff
RUN git config --global mergetool.prompt false
RUN git config --global mergetool.trustExitCode true

RUN git clone https://github.com/dbrandonk/.dotfiles
RUN mv .dotfiles/.bashrc-extra .bashrc-extra

# Doing some hacky writing to the .bashrc
RUN echo '. $HOME/.bashrc-extra' >> .bashrc
RUN echo 'source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash' >> ~/.bashrc
# This is a real hacky solution so tmux start when the container starts without it in the entrypoint call because that breaks the vim coloring for some reason
RUN echo 'export TERM=xterm-256color' >> .bashrc
RUN echo 'if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then' >> .bashrc
RUN echo 'exec tmux' >> .bashrc
RUN echo 'fi' >> .bashrc

RUN mv .dotfiles/.tmux.conf .tmux.conf
RUN mv .dotfiles/.vimrc .vimrc
RUN rm .dotfiles -rf

RUN rm .ssh -rf
ADD .ssh .ssh

# getting latest version of vim
RUN git clone https://github.com/vim/vim.git
RUN cd vim/src && make && checkinstall --pkgname vim -y
RUN rm -rf vim

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN vim -c ':PlugInstall' -c ':qall'
RUN mkdir .vim/tmp

ENTRYPOINT ["/bin/bash"]
