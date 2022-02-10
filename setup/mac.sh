#!/bin/sh

brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font

osascript setup/set-terminal-theme.applescript
