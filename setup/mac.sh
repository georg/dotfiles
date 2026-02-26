#!/bin/sh

brew tap homebrew/cask-fonts
brew install font-meslo-lg-nerd-font

osascript setup/set-terminal-theme.applescript
