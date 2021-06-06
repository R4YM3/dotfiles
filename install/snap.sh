#!/usr/bin/env bash

# Install snap packages

apps=(
    1password --edge
    beekeeper-studio
    chromium
    code --classic
    discord
    doctl
    gitkraken --classic
    glow
    go --classic
    gotop
    heroku --classic
    icloud-for-linux
    libreoffice
    mailspring
    opera
    postman
    skype --classic
    slack --classic
    slack-term
    spotify
    teams-for-linux
    vlc
)

sudo snap install "${apps[@]}"

sudo snap refresh
