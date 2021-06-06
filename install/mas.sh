#!/usr/bin/env bash

if ! brew ls --versions mas > /dev/null; then
    # Installing Mac Apple Store command line interface"
    brew tap mas-cli/tap
    brew tap-pin mas-cli/tap
    brew install mas
fi

APPLE_STORE_APPS=(
    497799835 # xcode
    402398561 # mindNode Pro
    422025166 # screenFlow
    409203825 # numbers
    409201541 # pages
)

install 'mas install' ${APPLE_STORE_APPS[@]}
