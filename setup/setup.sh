#!/bin/sh

# http://stackoverflow.com/a/246128
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$(uname -s)" = "Darwin" ]; then
  brew bundle --file="${DOTFILES}/Brewfile"

fi

if ! command -v stow >/dev/null 2>&1; then
  echo "Error: stow is not installed. Install it and try again." >&2
  exit 1
fi

# Set fish as default shell
FISH_PATH="$(which fish)"
CURRENT_SHELL="$(dscl . -read /Users/"$(whoami)" UserShell 2>/dev/null | awk '{print $2}' || getent passwd "$(whoami)" | cut -d: -f7)"
if [ "$CURRENT_SHELL" != "$FISH_PATH" ]; then
  if ! grep -qF "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi
  chsh -s "$FISH_PATH"
fi

cd "$DOTFILES/.."

stow --verbose --stow . --target ~

vim +PlugInstall +qall

# Install fisher and fish plugins
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update"

