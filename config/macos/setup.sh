#!/bin/bash

header "Mac OS"

# key repeat
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# tap to click (requires logout and login
defaults -currentHost write -globalDomain com.apple.mouse.tapBehavior -int 0

# dark mode
defaults write -g NSRequiresAquaSystemAppearance -bool true

# only active apps in dock
defaults write com.apple.dock static-only -bool true; killall Dock

# hide dock
defaults write com.apple.dock autohide-time-modifier -float 0.25;killall Dock
defaults read com.apple.Dock autohide

# save screenshots in downloads folder
defaults write com.apple.screencapture location ~/Downloads
