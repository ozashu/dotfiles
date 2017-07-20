export LANG=ja_JP.UTF-8
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
export GREP_OPTIONS='--color=auto'
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=$PATH:$HOME/go
export PATH=$PATH:$GOROOT/bin
export GOROOT=$HOME/go
export GOPATH=$HOME

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HIST_STAMPS="mm/dd/yyyy"

PROMPT='[%*][%F{magenta}%n%f@%F{green}%U%m%u%f:%F{blue}%B%d%f%b]

alias d='cd'
alias ..='cd ..'
alias la='ls -a'
alias ll='ls -l'
alias ks='ls'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias sudo='sudo '
alias -g L='| less'
alias -g G='| grep'
alias ls='ls -F --color=auto'
alias q='exit'
alias ipv4='ifconfig eth0 | egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" | sed -n 1p'
alias ipv6='ifconfig eth0 | egrep -o "([[:xdigit:]]{0,4}[:]){7}[[:xdigit:]]{0,4}" | sed -n 1p'
alias mac='ifconfig eth0 | egrep -o "([[:xdigit:]]{2}[:]){5}[[:xdigit:]]{2}"'
alias nocaps='setxkbmap -option ctrl:nocaps'
alias trl='tr "A-Z" "a-z"'
alias tru='tr "a-z" "A-Z"'
alias socat='(){socat TCP-LISTEN:$1,,reuseaddr,fork EXEC:$2&}'
