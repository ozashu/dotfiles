#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_PACKAGES=false

usage() {
  cat <<'EOF'
Usage: ./setup.sh [--packages]

Create dotfile links for the current user. Pass --packages to also install
packages for the detected operating system.
EOF
}

while (($#)); do
  case "$1" in
    --packages)
      INSTALL_PACKAGES=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

backup_and_link() {
  local source_path="$1"
  local target_path="$2"
  local backup_path

  if [[ -L "$target_path" ]] &&
    [[ "$(readlink "$target_path")" == "$source_path" ]]; then
    printf 'Already linked: %s\n' "$target_path"
    return
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    backup_path="${target_path}.backup.$(date +%Y%m%d%H%M%S)"
    mv -- "$target_path" "$backup_path"
    printf 'Backed up: %s -> %s\n' "$target_path" "$backup_path"
  fi

  ln -s -- "$source_path" "$target_path"
  printf 'Linked: %s -> %s\n' "$target_path" "$source_path"
}

for path in .zshrc .tmux.conf .gitconfig; do
  backup_and_link "$DOTFILES_DIR/$path" "$HOME/$path"
done

mkdir -p "$HOME/.config"
backup_and_link "$DOTFILES_DIR/.tmux" "$HOME/.tmux"
backup_and_link "$DOTFILES_DIR/herdr" "$HOME/.config/herdr"
backup_and_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

if [[ "$INSTALL_PACKAGES" == true ]]; then
  case "$(uname -s)" in
    Darwin)
      "$DOTFILES_DIR/setup/macos.sh"
      ;;
    Linux)
      if [[ -r /etc/os-release ]]; then
        # shellcheck disable=SC1091
        . /etc/os-release
      fi
      if [[ "${ID:-}" != ubuntu && "${ID_LIKE:-}" != *ubuntu* ]]; then
        printf 'Package installation supports Ubuntu only (detected: %s).\n' \
          "${ID:-unknown}" >&2
        exit 1
      fi
      "$DOTFILES_DIR/setup/ubuntu.sh"
      ;;
    *)
      printf 'Unsupported operating system: %s\n' "$(uname -s)" >&2
      exit 1
      ;;
  esac
fi

if command -v zsh >/dev/null 2>&1; then
  zsh_path="$(command -v zsh)"
  current_shell="$(readlink -f "${SHELL:-/bin/sh}")"
  if [[ "$current_shell" != "$(readlink -f "$zsh_path")" ]]; then
    printf 'To use zsh by default, run: chsh -s %q\n' "$zsh_path"
  fi
fi

printf 'Dotfiles setup finished.\n'
