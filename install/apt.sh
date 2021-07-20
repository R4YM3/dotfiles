#!/usr/bin/env bash

header "Apt"

# Install apt

apps=(
    build-essential
    libssl-dev
    git
    curl
    cmake
    python3
    make

    ubuntu-restricted-extras # set early, because unskippable EULA

    ack-grep
    apt-transport-https
    awscli
    ca-certificates
    catimg
    default-jdk
    docker-ce
    fonts-firacode
    fonts-powerline
    gimp
    git-all
    git-crypt
    gnome-tweak-tool
    graphviz
    htop
    # kubectl
    lynx
    mono-xbuild
    ncdu
    neovim
    nodejs
    openconnect
    openssh-server
    powerline
    preload
    python3-pip
    snapd
    tmux
    tmuxinator

    virtualbox
    zsh
)

sudo apt-get autoremove -y
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get full-upgrade -y

for i in "${apps[@]}"
do
  sudo apt-get install -y $i
done

if ! command -v google-chrome --version &> /dev/null
then
    wget -P ~/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ~/Downloads/google-chrome-stable_current_amd64.deb
    rm -rf ~/Downloads/google-chrome-stable_current_amd64.deb

    sudo apt install chrome-gnome-shell
fi

sudo add-apt-repository ppa:lutris-team/lutris
sudo apt update
sudo apt install lutris
