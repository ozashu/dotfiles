#!/usr/bin/env bash

set -euo pipefail

printf 'setup_ubun.sh is deprecated; using setup/ubuntu.sh.\n' >&2
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
exec "$DOTFILES_DIR/setup/ubuntu.sh"
