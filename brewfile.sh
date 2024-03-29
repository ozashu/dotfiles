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

#jump
brew install jump

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
brew install emap
brew install sipcalc
brew install sysbench
brew install sqldef/sqldef/mysqldef

# Linux virtual machines on macOS
brew install lima

## anyenv
brew install anyenv

## python3
brew install python3

#font
brew tap sanemat/font

## peco
brew install go
brew install peco

## go
brew install ghq

## fzf
brew install fzf

## yq
brew install yq

## jq
brew install jq

## bat
brew install bat

## k8s
brew install kubectl
brew install minikube --cask
brew install cfssl
brew install kubectx
brew install stern
brew tap derailed/k9s && brew install k9s
brew install txn2/tap/kubefwd
brew install kube-ps1
brew install aylei/tap/kubectl-debug
brew install helm
brew install istioctl

## mysql client
brew install mycli

## modern watch command
#brew install sachaos/tap/viddy
go install github.com/sachaos/viddy@latest

## tail AWS CloudWatch Logs
#brew tap knqyf263/utern
#brew install knqyf263/utern/utern
git clone https://github.com/knqyf263/utern.git
cd utern
go install

## Ansible
brew install ansible

## eksctl
brew tap weaveworks/tap
brew install weaveworks/tap/eksctl

## HashiCorp
brew install packer
brew install tfenv
brew install consul
brew install terraform

## pre-commit
brew install pre-commit

## Homebrew-cask
brew tap caskroom/cask
brew install adobe-reader --cask
brew install xquartz --cask
brew install skype --cask

## Ricty font
brew install --cask fontforge
brew install ricty
#To install Ricty:
cp -f /opt/homebrew/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf

## Vagrant
brew install virtualbox --cask
brew install vagrant --cask
brew install vagrant-manager --cask
vagrant plugin install vagrant-hostupdater
vagrant plugin install vagrant-sshfs

#remove dust
brew cleanup

#tmux enable copy-paste on Vim
brew install reattach-to-user-namespace

# direnv
brew install direnv

# mackerel CUI
brew tap mackerelio/mackerel-agent
brew install mkr

# axel
brew install axel

# imagemagick
brew install imagemagick

# protobuf
brew install protobuf

# grpc
brew install grpcurl

# kubesec
brew install shyiko/kubesec/kubesec

# bloomrpc
brew install bloomrpc --cask

# Azure CLI
brew install azure-cli

# Google Cloud SDK
brew install google-cloud-sdk --cask

# aws
brew install aws-iam-authenticator
brew install fujiwara/tap/kinesis-tailf
