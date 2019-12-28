#!/bin/sh

brew tap homebrew/cask-fonts
brew cask install font-source-code-pro

osascript setup/set-terminal-theme.applescript
