#!/bin/bash

DOT_FILES=(.zshrc .vim .vimrc .tmux .tmux.conf .gitconfig .gemrc dein_lazy.toml dein.toml)
RCFILE=(.${SHELL}rc)

for file in ${DOT_FILES[@]}
do
ln -s $HOME/dotfiles/$file $HOME/$file
done

if [ ! -d ~/.vim/.cache/dein/ ]; then
    mkdir -p ~/.vim/.cache/dein/
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

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

chsh -s $(which zsh)

echo "Finished!"
