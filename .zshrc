export LANG=ja_JP.UTF-8
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
export PATH=$PATH:$HOME/.rbenv/bin
export PATH=$PATH:~/Downloads/nand2tetris/tools
export PATH=$PATH:/opt/homebrew/bin
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=on
export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:~/google-cloud-sdk/bin
export PATH=$PATH:~/CAWORK/01_work/cycloud_Darwin_x86_64/
export LESSCHARSET=utf-8
export LESS='--no-init --shift 4 --LONG-PROMPT --RAW-CONTROL-CHARS --quit-if-one-screen'
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

eval "$(rbenv init -)"
eval "$(anyenv init -)"
eval "$(direnv hook zsh)"

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HIST_STAMPS="mm/dd/yyyy"

autoload -Uz vcs_info
autoload -U compinit && compinit
autoload -U colors;colors


# git-promptの読み込み
source ~/dotfiles/git-prompt.sh

# git-completionの読み込み
#path=(~/dotfiles $fpath)
#zstyle ':completion:*:*:git:*' script ~/dotfiles/git-completion.bash
#autoload -U compinit && compinit

# グロブ展開を防ぐ
setopt nonomatch
# PROMPT変数内で変数参照する
setopt prompt_subst
# プロンプトのオプション表示設定
# PROMPT：左側に表示されるの通常のプロンプト
# PROMPT2：2行以上のコマンドを入力する際に表示されるプロンプト
# SPROMPT：コマンドを打ち間違えたときの「もしかして」プロンプト
# RPROMPT：右側に表示されるプロンプト (入力が被ると自動的に消える)

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

PROMPT='[%*][%F{magenta}%n%f@%F{green}%U%m%u%f:%F{blue}%B%d%f%b %F{red}$(__git_ps1 "(%s)")%f]'
PROMPT2="%{${fg[yellow]}%} %_ > %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r ? [n,y,a,e] %{${reset_color}%}"

# プロンプトの表示設定(好きなようにカスタマイズ可)
#setopt PROMPT_SUBST ; PS1='%F{green}%n@%m%f: %F{cyan}%~%f %F{red}$(__git_ps1 "(%s)")%f
#\$ '

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
alias irb='irb --simple-prompt'
alias k='kubectl'
alias k9s='k9s --readonly'
alias ke='kubectl exec'
alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgpall='kubectl get pods --all-namespaces'
alias kge='kubectl get events'
alias gitls='git ls-files'

# function
function peco-select-history() {
    # historyを番号なし、逆順、最初から表示。
    # 順番を保持して重複を削除。
    # カーソルの左側の文字列をクエリにしてpecoを起動
    # \nを改行に変換
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER             # カーソルを文末に移動
    zle -R -c                   # refresh
}
zle -N peco-select-history
bindkey '^R' peco-select-history

# zsh 補完
source <(kubectl completion zsh)
source <(stern --completion=zsh)
# dogleash
#dogleash completion zsh > /usr/local/share/zsh/site-functions/_dogleash
#if [ $commands[dogleash] ]; then
#  source <(dogleash completion zsh)
#fi
#source <(dogleash completion zsh)

# paco-src
bindkey '^]' peco-src
function peco-src() {
  local src=$(ghq list --full-path ¦ peco --query "$LBUFFER")
  if [ -n "$src" ]; then
      BUFFER="cd $src"
      zle accept-line
  fi
  zle -R -c
}
zle -N peco-src

# vscode
function code {
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        local argPath="$1"
        [[ $1 = /* ]] && argPath="$1" || argPath="$PWD/${1#./}"
        open -a "Visual Studio Code" "$argPath"
    fi
}

# krew
result=0
output=$(kubectl krew 2>&1 > /dev/null) || result=$?
if [ ! "$result" = "0" ]; then
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"${OS}_${ARCH}" &&
  "$KREW" install krew
)
fi

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
#export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

source ~/.bash_profile
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

PATH="/Users/s04503/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/s04503/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/s04503/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/s04503/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/s04503/perl5"; export PERL_MM_OPT;

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/s04503/CAWORK/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/s04503/CAWORK/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/s04503/CAWORK/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/s04503/CAWORK/google-cloud-sdk/completion.zsh.inc'; fi
