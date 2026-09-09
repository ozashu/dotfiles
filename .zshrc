DOTFILES_DIR="${0:A:h}"

case "$OSTYPE" in
  darwin*)
    source "$DOTFILES_DIR/zsh/macos.zsh"
    ;;
  linux*)
    source "$DOTFILES_DIR/zsh/ubuntu.zsh"
    ;;
esac

source "$DOTFILES_DIR/zsh/common.zsh"

[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

unset DOTFILES_DIR
