#!/usr/bin/env bash

header "Snap"

# Install snap packages

apps=(
    1password --edge
    beekeeper-studio
    chromium
    code --classic
    discord
    doctl
    gitkraken --classic
    go --classic
    gotop
    heroku --classic
    icloud-for-linux
    libreoffice
    mailspring
    opera
    postman
    slack --classic
    slack-term
    spotify
    teams-for-linux
    vlc
)


for i in "${apps[@]}"
do
  sudo snap install $i
done

sudo snap refresh
