ARG BASE_IMAGE
# ubuntu:20.04

FROM ${BASE_IMAGE}
WORKDIR /root

ARG GIT_EMAIL

# getting apt in a happy state
RUN apt autoremove --purge \
&& apt clean \
&& apt update -y

# export timezone and place timezone data /etc/timezone
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# installing packages I like
COPY apt_packages.txt apt_packages.txt
RUN apt install $(cat apt_packages.txt) -y --fix-missing
RUN rm apt_packages.txt

# Check if pip is installed, if not install it.
RUN command -v pip || (apt install -y python3-pip)

RUN pip install \
autopep8 \
ipython \
magic-wormhole \
monkeytype \
mypy \
pylint

# fixing install of fzf if there is an issue
RUN ./.fzf/uninstall || true
RUN rm -rf ./.fzf
# RUN apt install fzf -y
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install --all

# installing google chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN DEBIAN_FRONTEND=noninteractive apt install ./google-chrome*.deb -y
RUN rm -rf ./google-chrome*.deb

# unminimize the docker
# RUN yes | unminimize || true

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
RUN echo 'export TERM=xterm-256color' >> .bashrc \
&& echo 'if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then' >> .bashrc \
&& echo 'exec tmux' >> .bashrc \
&& echo 'fi' >> .bashrc
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

# All the vim plugins.
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN vim -c ':PlugInstall' -c ':qall'
RUN mkdir -p .vim/tmp

# nvim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
RUN rm -rf /opt/nvim && tar -C /opt -xzf nvim-linux-x86_64.tar.gz && rm -rf nvim-linux-x86_64.tar.gz
# nvchad
RUN git clone https://github.com/dbrandonk/nvchad-starter.git ~/.config/nvim && rm -rf ~/.config/nvim/.git
RUN mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts && wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip && unzip JetBrainsMono.zip && rm -rf JetBrainsMono.zip
RUN export PATH="$PATH:/opt/nvim-linux-x86_64/bin" && nvim -c ':MasonInstallAll' -c ':qall'
# I don't like this but I can't find a better solution right now.
RUN export PATH="$PATH:/opt/nvim-linux-x86_64/bin" && nvim -c ':MasonInstall jedi_language_server' -c ':qall'

CMD ["/bin/bash"]
