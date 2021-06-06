#!/usr/bin/env bash

which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install cask packages

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

    # Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
    apparency
    qlcolorcode
    qlmarkdown
    qlprettypatch
    qlstephen
    qlvideo
    quicklook-csv
    quicklook-json
    quicklookase
    suspicious-package
    webpquicklook
)

header "Brew cask"

BREW_LIST=$(brew list)

for i in "${apps[@]}"
do
  echo $BREW_LIST | grep $i &>/dev/null
  if [[ $? != 0 ]] ; then
    brew install --cask $i
  else
    already_installed $i
  fi
done
