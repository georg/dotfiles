#!/bin/sh

DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if ! command -v stow >/dev/null 2>&1; then
  echo "Error: stow is not installed. Install it and try again." >&2
  exit 1
fi

cd "$DOTFILES/.."

stow --verbose --delete . --target ~

# Remove any broken symlinks that still point into the dotfiles repo
find ~ -maxdepth 3 -type l ! -exec test -e {} \; -print | while read -r link; do
  target=$(readlink "$link")
  case "$target" in
    *dotfiles/*) echo "Removing broken symlink: $link"; rm "$link" ;;
  esac
done
