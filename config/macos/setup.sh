#!/bin/bash

header "Mac OS"

# key repeat
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# tap to click (requires logout and login
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
sudo defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# dark mode
defaults write -g NSRequiresAquaSystemAppearance -bool true

# remove all apps from dock
defaults write com.apple.dock persistent-apps -array

# hide dock
defaults write com.apple.dock autohide-time-modifier -float 0.25;killall Dock
defaults read com.apple.Dock autohide
osascript -e 'tell application "System Events" to set autohide of dock preferences to not (autohide of dock preferences)'

# restart dock
killall Dock

# save screenshots in downloads folder
defaults write com.apple.screencapture location ~/Downloads

# set wallpaper
sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$DOTFILES_DIR/wallpaper.jpg'";
killall Dock;
