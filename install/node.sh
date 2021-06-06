#!/usr/bin/env bash

# TODO: not so nice patch  when  nvm is not found
if [ -d "$HOME/.nvm" ];then
    [[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
fi

# TODO nvm command not found
nvm install 14.15.0
nvm use 14.15.0
nvm alias default 14.15.0

# Globally install with npm

packages=(
    eslint
    grunt
    gulp
    http-server
    nodemon
)

npm install -g "${packages[@]}"
