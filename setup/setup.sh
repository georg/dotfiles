#!/bin/sh

# http://stackoverflow.com/a/246128
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$DOTFILES/.."

stow --verbose --stow . --target ~

if [[ $(uname -s) == "Darwin" ]]; then
  sh "${DOTFILES}/mac.sh"
fi

vim +PluginInstall +qall

