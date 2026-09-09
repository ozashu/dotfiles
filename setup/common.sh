#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  printf 'Homebrew is required for the shared CLI packages.\n' >&2
  printf 'Install it from https://brew.sh and rerun this script.\n' >&2
  exit 1
}

install_common_packages() {
  install_homebrew
  brew update
  brew bundle --file="$DOTFILES_DIR/Brewfile"
  install_vim_plugins
}

install_vim_plugins() {
  local dein_dir="$HOME/.cache/dein"
  local dein_repo="$dein_dir/repos/github.com/Shougo/dein.vim"

  if [[ ! -d "$dein_repo/.git" ]]; then
    mkdir -p "$(dirname -- "$dein_repo")"
    git clone --depth=1 https://github.com/Shougo/dein.vim "$dein_repo"
  fi

  vim -Nu "$DOTFILES_DIR/.vimrc" -n -es \
    '+call dein#install()' '+call dein#recache_runtimepath()' '+qa'
}
