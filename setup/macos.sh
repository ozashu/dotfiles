#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=setup/common.sh
. "$SCRIPT_DIR/common.sh"

if [[ "$(uname -s)" != Darwin ]]; then
  printf 'This installer only supports macOS.\n' >&2
  exit 1
fi

install_brew_packages
brew bundle --file="$DOTFILES_DIR/Brewfile.macos"
install_neovim_plugins
