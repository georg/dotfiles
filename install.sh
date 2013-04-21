#!/bin/sh
for file in `cat FILES`; do
  source="$PWD/$file"
  target="$HOME/$file"
  if [ -L "$target" -o ! -a "$target" ]; then
    rm -f $target
    ln -sv $source $target
  else
    echo "$target exists but is not a symlink."
  fi
done

