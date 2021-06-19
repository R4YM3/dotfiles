#!/usr/bin/env bash

if ! brew ls --versions mas > /dev/null; then
    # Installing Mac Apple Store command line interface"
    brew tap mas-cli/tap
    brew tap-pin mas-cli/tap
    brew install mas
fi

APPLE_STORE_APPS=(
    402398561 # mindNode Pro
    422025166 # screenFlow
    409203825 # numbers
    409201541 # pages
)

header "Install Apple Store apps"

MAS_LIST=$(mas list)

for i in "${APPLE_STORE_APPS[@]}"
do
  echo $MAS_LIST | grep $i &>/dev/null
  if [[ $? != 0 ]] ; then
    mas install $i
  else
    already_installed $(mas list | grep $i)
  fi
done


