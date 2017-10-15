export LANG=ja_JP.UTF-8
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=$PATH:$HOME/go
export PATH=$PATH:$GOROOT/bin
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME
export PATH=$PATH:~/Downloads/nand2tetris/tools

eval "$(rbenv init -)"

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HIST_STAMPS="mm/dd/yyyy"

autoload -Uz vcs_info
autoload -U compinit && compinit
autoload -U colors;colors

PROMPT='[%*][%F{magenta}%n%f@%F{green}%U%m%u%f:%F{blue}%B%d%f%b]'
PROMPT2="%{${fg[yellow]}%} %_ > %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r ? [n,y,a,e] %{${reset_color}%}"

# ls
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# 大文字と小文字を同一視して補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# フルパスの時でも今のディレクトリを外す場合の設定
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:processes' command 'ps x -o pid,args'

# alias
alias d='cd'
alias ..='cd ..'
alias ls='ls -F -G'
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
alias q='exit'
alias ipv4='ifconfig eth0 | egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" | sed -n 1p'
alias ipv6='ifconfig eth0 | egrep -o "([[:xdigit:]]{0,4}[:]){7}[[:xdigit:]]{0,4}" | sed -n 1p'
alias mac='ifconfig eth0 | egrep -o "([[:xdigit:]]{2}[:]){5}[[:xdigit:]]{2}"'
alias nocaps='setxkbmap -option ctrl:nocaps'
alias trl='tr "A-Z" "a-z"'
alias tru='tr "a-z" "A-Z"'
alias socat='(){socat TCP-LISTEN:$1,,reuseaddr,fork EXEC:$2&}'
alias s='ssh s'
alias irb='irb --simple-prompt'
