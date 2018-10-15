#!/bin/bash -eu

#update Homebrew
brew update
brew upgrade

#shell
brew install zsh
brew install coreutils

#git
brew install git
brew install git-flow

# node.js
brew install node.js
brew install yarn

#tools
brew install tmux
brew install nkf
brew install vim --with-lua
brew install w3m
brew install curl
brew install wget
brew install tree
brew install nmap

## python3
brew install python3

#font
brew tap sanemat/font

## peco
brew install go
brew tap peco/peco
brew install peco

# k8s
brew install kubectl
brew cask install minikube

# HashiCorp
brew install packer
brew install terraform
brew install consul

## Homebrew-cask
brew tap caskroom/cask
brew cask install adobe-reader
brew cask install xquartz
brew cask install skype

## Vagrant
brew cask install virtualbox
brew cask install vagrant
brew cask install vagrant-manager
vagrant plugin install vagrant-hostupdater
vagrant plugin install vagrant-sshfs

#remove dust
brew cleanup

#tmux enable copy-paste on Vim
brew install reattach-to-user-namespace

# tfenv and direnv
brew install direnv
brew install tfenv
