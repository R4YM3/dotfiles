#!/usr/bin/env bash

header "Brew"

which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # add homwbrew to PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/voyager/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install packages

apps=(
    ack
    cmake
    docker
    docker-compose
    ffmpeg
    git
    go
    htop
    lolcat
    lynx
    mono
    ncdu
    neovim
    node
    openvpn
    openconnect
    python
    tmux
    tmuxinator
    vim
    wget
    zsh
)

BREW_LIST=$(brew list)

for i in "${apps[@]}"
do
  echo $BREW_LIST | grep $i &>/dev/null
  if [[ $? != 0 ]] ; then
    brew install $i
  else
    already_installed $i
  fi
done

# Git comes with diff-highlight, but isn't in the PATH -> https://github.com/myshov/dotfiles/blob/master/install/brew.shv
ln -sf "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" /usr/local/bin/diff-highlight
