#!/bin/bash

DOT_FILES=(.zshrc .vim .vimrc .tmux .tmux.conf .gitconfig .gemrc)
RCFILE=(.${SHELL}rc)

for file in ${DOT_FILES[@]}
do
ln -s $HOME/dotfiles/$file $HOME/$file
done

mkdir -p $HOME/go
mkdir -p $HOME/.vim/dein/repos/github.com/Shougo/dein.vim
git clone https://github.com/Shougo/dein.vim.git $HOME/.vim/dein/repos/github.com/Shougo/dein.vim

if [ ! -d ~/.rbenv/ ]; then
    mkdir -p ~/.rbenv/
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

chsh -s $(which zsh)

echo "Finished!"
