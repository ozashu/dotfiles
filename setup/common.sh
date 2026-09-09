#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  printf 'Homebrew is required for the macOS packages.\n' >&2
  printf 'Install it from https://brew.sh and rerun this script.\n' >&2
  exit 1
}

install_brew_packages() {
  install_homebrew
  brew update
  brew bundle --file="$DOTFILES_DIR/Brewfile"
}

install_neovim_ubuntu() (
  local architecture
  local archive
  local install_dir
  local temporary_dir

  case "$(uname -m)" in
    x86_64)
      architecture="x86_64"
      ;;
    aarch64|arm64)
      architecture="arm64"
      ;;
    *)
      printf 'Unsupported architecture for Neovim: %s\n' "$(uname -m)" >&2
      exit 1
      ;;
  esac

  archive="nvim-linux-${architecture}.tar.gz"
  install_dir="/opt/nvim-linux-${architecture}"
  temporary_dir="$(mktemp -d)"
  trap 'rm -rf -- "$temporary_dir"' EXIT

  curl --fail --location --show-error \
    "https://github.com/neovim/neovim/releases/latest/download/$archive" \
    --output "$temporary_dir/$archive"
  tar -C "$temporary_dir" -xzf "$temporary_dir/$archive"

  sudo rm -rf -- "$install_dir"
  sudo mv -- "$temporary_dir/nvim-linux-${architecture}" "$install_dir"
  sudo ln -sfn -- "$install_dir/bin/nvim" /usr/local/bin/nvim
)

install_neovim_plugins() {
  if ! command -v nvim >/dev/null 2>&1; then
    printf 'Neovim is required before plugins can be installed.\n' >&2
    exit 1
  fi

  nvim --headless '+Lazy! sync' '+qa'
}
