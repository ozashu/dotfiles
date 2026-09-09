export LESS='--no-init --shift 4 --LONG-PROMPT --RAW-CONTROL-CHARS --quit-if-one-screen'
export LESSCHARSET=utf-8
export RUBYOPT=-EUTF-8

typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "${KREW_ROOT:-$HOME/.krew}/bin"
  "$HOME/go/bin"
  $path
)
if [[ -n "${HOMEBREW_PREFIX:-}" ]]; then
  path=(
    "$HOMEBREW_PREFIX/opt/node@24/bin"
    "$HOMEBREW_PREFIX/opt/helm@3/bin"
    $path
  )
fi

if [[ -d "$HOME/.rbenv/bin" ]]; then
  path=("$HOME/.rbenv/bin" $path)
fi
if [[ -d "$HOME/.anyenv/bin" ]]; then
  path=("$HOME/.anyenv/bin" $path)
fi

if (( $+commands[rbenv] )); then
  eval "$(rbenv init - zsh)"
fi
if (( $+commands[anyenv] )) &&
  [[ -d "${XDG_CONFIG_HOME:-$HOME/.config}/anyenv/anyenv-install" ]]; then
  eval "$(anyenv init -)"
fi
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt append_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt inc_append_history
setopt nonomatch
setopt prompt_subst
setopt share_history

autoload -Uz add-zsh-hook colors compinit vcs_info
colors
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"
[[ -d "$HOME/.cache/zsh" ]] || mkdir -p "$HOME/.cache/zsh"
compinit -d "$HOME/.cache/zsh/zcompdump"

zstyle ':vcs_info:git:*' formats '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' check-for-changes true
function update-vcs-info() {
  vcs_info
}
add-zsh-hook precmd update-vcs-info

typeset -g kubernetes_context_prompt=''
function update-kubernetes-context() {
  kubernetes_context_prompt=''
  (( $+commands[kubectl] )) || return

  local context
  context="$(kubectl config current-context 2>/dev/null)" || return
  [[ -n "$context" ]] || return
  context="${context//\%/%%}"
  kubernetes_context_prompt=" %F{cyan}k8s:${context}%f"
}
add-zsh-hook precmd update-kubernetes-context

PROMPT='[%*][%F{magenta}%n%f@%F{green}%U%m%u%f:%F{blue}%B%~%f%b %F{red}${vcs_info_msg_0_}%f${kubernetes_context_prompt}] '
PROMPT2='%F{yellow}%_ > %f'
SPROMPT='%F{red}correct: %R -> %r ? [n,y,a,e]%f '

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:processes' command 'ps x -o pid,args'

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
alias q='exit'
alias trl='tr "A-Z" "a-z"'
alias tru='tr "a-z" "A-Z"'
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

function peco-select-history() {
  local selected
  selected="$(fc -rl 1 | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//' |
    awk '!seen[$0]++' | peco --query "$LBUFFER")" || return
  BUFFER="$selected"
  CURSOR=${#BUFFER}
  zle reset-prompt
}
if (( $+commands[peco] )); then
  zle -N peco-select-history
  bindkey '^R' peco-select-history
fi

function peco-src() {
  local src
  src="$(ghq list --full-path | peco --query "$LBUFFER")" || return
  [[ -n "$src" ]] || return
  BUFFER="cd ${(q)src}"
  zle accept-line
}
if (( $+commands[ghq] && $+commands[peco] )); then
  zle -N peco-src
  bindkey '^]' peco-src
fi

function peco-kubectl-switch-context() {
  local context
  context="$(kubectl config get-contexts -o name | peco \
    --prompt='kubectl config use-context > ')" || return
  [[ -n "$context" ]] && kubectl config use-context "$context"
}
alias kctx='peco-kubectl-switch-context'

function peco-kubectl-ssh-jump() {
  local node ip_address
  node="$(kubectl get nodes -o name | sed 's|^node/||' |
    peco --prompt='kubectl ssh-jump > ')" || return
  [[ -n "$node" ]] || return
  ip_address="$(kubectl get node "$node" \
    -o jsonpath='{.status.addresses[?(@.type=="InternalIP")].address}')"
  [[ -n "$ip_address" ]] && kubectl ssh-jump "$ip_address"
}
alias kssh='peco-kubectl-ssh-jump'

function gcloud-activate() {
  local name="$1"
  print -r -- "gcloud config configurations activate ${(q)name}"
  gcloud config configurations activate "$name"
}

function gx-complete() {
  _values 'configuration' \
    ${(f)"$(gcloud config configurations list --format='value(name)' 2>/dev/null)"}
}

function gx() {
  local name="${1:-}"
  if [[ -z "$name" ]]; then
    name="$(gcloud config configurations list --format='value(name)' | peco)" ||
      return
  fi
  [[ -n "$name" ]] && gcloud-activate "$name"
}
if (( $+commands[gcloud] )); then
  compdef gx-complete gx
fi
