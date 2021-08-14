#!/bin/bash

DOT_FILES=(.zshrc .vim .vimrc .tmux .tmux.conf .gitconfig .gemrc dein_lazy.toml dein.toml)
RCFILE=(.${SHELL}rc)

for file in ${DOT_FILES[@]}
do
ln -s $HOME/dotfiles/$file $HOME/$file
done

if [ ! -d ~/dotfiles/.vim/.cache/dein/ ]; then
    mkdir -p ~/dotfiles/.vim
    mkdir -p ~/dotfiles/.vim/.cache/dein/
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
    sh ./installer.sh ~/.vim/.cache/dein/
    rm -rf ./installer.sh
fi

mkdir -p $HOME/go

if [ ! -d ~/.rbenv/ ]; then
    mkdir -p ~/.rbenv/
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

if [ ! -d ~/.config/anyenv/ ]; then
    anyenv install --init
    anyenv install nodenv
    mkdir -p $(anyenv root)/plugins
    git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
    mkdir -p "$(nodenv root)"/plugins
    git clone https://github.com/nodenv/nodenv-default-packages.git "$(nodenv root)/plugins/nodenv-default-packages"
    touch $(nodenv root)/default-packages
    echo yarn >> $(nodenv root)/default-packages
    echo typescript >> $(nodenv root)/default-packages
    echo ts-node >> $(nodenv root)/default-packages
    echo typesync >> $(nodenv root)/default-packages
fi

if [ ! -d ~/dotfiles/.tmux ]; then
    mkdir -p ~/dotfiles/.tmux
    cd ~/dotfiles/.tmux
    wget https://raw.githubusercontent.com/jonmosco/kube-tmux/master/kube.tmux
fi


if [ ! -d $HOME/.cargo/bin ]; then
    curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
fi


if [ ! -d /opt/homebrew ]; then
    mkdir /opt/homebrew
fi

if [ ! -e /usr/local/bin/telepresence ]; then
    sudo curl -fL https://app.getambassador.io/download/tel2/darwin/amd64/latest/telepresence -o /usr/local/bin/telepresence
    sudo chmod a+x /usr/local/bin/telepresence
fi

curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C /opt/homebrew
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

chsh -s $(which zsh)

echo "Finished!"
