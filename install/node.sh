#!/usr/bin/env bash

header "Node"

# TODO: not so nice patch  when  nvm is not found
if [ -d "$HOME/.nvm" ];then
    [[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
fi

nvm install 14.15.0
nvm use 14.15.0
nvm alias default 14.15.0

# packages to instalal globally
packages=(
    eslint
    grunt
    gulp
    http-server
    nodemon
)

NPM_GLOBAL_LIST=$(npm -g list)

for i in "${packages[@]}"
do
  echo $NPM_GLOBAL_LIST | grep $i &>/dev/null
  if [[ $? != 0 ]] ; then
    npm install -g $i
  else
    already_installed $i
  fi
done
