#!/usr/bin/env bash

which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

# Install cask packages

brew install --cask

apps=(
    1password
    firefox
    gitkraken
    gitup
    google-chrome
    iterm2
    macdown
    notion
    opera
    postman
    slack
    tidal
    vlc
    whatsapp
)

brew install --cask "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv webpquicklook suspicious-package && qlmanage qlimagesize apparency quicklookase qlvideo -r
