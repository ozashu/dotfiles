if locale -a 2>/dev/null | grep -Eiq '^ja_JP\.utf-?8$'; then
  export LANG=ja_JP.UTF-8
  export LC_ALL=ja_JP.UTF-8
fi
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

typeset -U path PATH
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -x "$HOME/.linuxbrew/bin/brew" ]]; then
  eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
fi

alias ls='ls -F --color=auto'

function clipboard-copy() {
  if (( $+commands[wl-copy] )); then
    wl-copy
  elif (( $+commands[xclip] )); then
    xclip -selection clipboard
  else
    print -u2 'Install wl-clipboard or xclip to use the clipboard.'
    return 1
  fi
}

function clipboard-paste() {
  if (( $+commands[wl-paste] )); then
    wl-paste --no-newline
  elif (( $+commands[xclip] )); then
    xclip -selection clipboard -o
  else
    print -u2 'Install wl-clipboard or xclip to use the clipboard.'
    return 1
  fi
}
