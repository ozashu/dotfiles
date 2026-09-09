#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=setup/common.sh
. "$SCRIPT_DIR/common.sh"

if [[ "$(uname -s)" != Linux ]] || [[ ! -r /etc/os-release ]]; then
  printf 'This installer only supports Ubuntu.\n' >&2
  exit 1
fi

# shellcheck disable=SC1091
. /etc/os-release
if [[ "${ID:-}" != ubuntu && "${ID_LIKE:-}" != *ubuntu* ]]; then
  printf 'This installer only supports Ubuntu (detected: %s).\n' \
    "${ID:-unknown}" >&2
  exit 1
fi

sudo apt-get update
xargs -r sudo apt-get install -y < "$DOTFILES_DIR/packages/ubuntu.txt"
if ! locale -a | grep -Eiq '^ja_JP\.utf-?8$'; then
  sudo locale-gen ja_JP.UTF-8
fi

install_herdr_ubuntu
install_neovim_ubuntu
install_neovim_plugins
