#!/usr/bin/env bash

which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

# Install packages

apps=(
    cmake
    docker
    docker-compose
    ffmpeg
    git
    go
    mono
    neovim
    nodejs
    openvpn
    python
    tmux
    tmuxinator
    vim
    wget
    zsh
)

brew install "${apps[@]}"

# Git comes with diff-highlight, but isn't in the PATH -> https://github.com/myshov/dotfiles/blob/master/install/brew.shv
ln -sf "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" /usr/local/bin/diff-highlight
