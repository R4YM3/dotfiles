#!/usr/bin/env bash
export DOTFILES_DIR
export CONFIG_DIR
export DRIVERS_DIR
export PROJECTS_DIR
export DEVELPMENT_DIR

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR="$DOTFILES_DIR/config"
INSTALL_DIR="$DOTFILES_DIR/install"
DRIVERS_DIR="$DOTFILES_DIR/drivers"
PROJECTS_DIR="$DOTFILES_DIR/projects"
DEVELOPMENT_DIR=~/Development

source ./helpers.sh

function setup_environment {
  clear

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    setup_linux
    setup_generic
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    setup_macos
    setup_generic
  else
    echo "Error: not able to setup environment: unknown OS"
  fi
}

function setup_linux {
  source $INSTALL_DIR/apt.sh
  source $INSTALL_DIR/snap.sh
  source $CONFIG_DIR/gnome/setup.sh
}

function setup_macos {
  read -p "Please login App Store to install apps from App Store,  press <enter> to continue"
  clear

  source $INSTALL_DIR/xcode.sh
  source $INSTALL_DIR/mas.sh
  source $INSTALL_DIR/brew.sh
  source $INSTALL_DIR/brew-cask.sh
  source $CONFIG_DIR/macos/setup.sh
  source $CONFIG_DIR/iterm.sh
}

function setup_generic {
  source $CONFIG_DIR/zsh/setup.sh
  source $CONFIG_DIR/dotfiles/setup.sh
  source $INSTALL_DIR/node.sh
  source $CONFIG_DIR/nvim/setup.sh
  source $CONFIG_DIR/tmux/setup.sh
  source $CONFIG_DIR/tmuxinator/setup.sh
}

function setup_development_projects {
  clear
  source $PROJECTS_DIR/install.sh
}


function install_drivers {
  mkdir -p $DRIVERS_DIR
  download_repository git@bitbucket.org:R4YM3/private-drivers-installer.git $DRIVERS_DIR
  install_tmuxinator_project "$DRIVERS_DIR/tmuxinator.yml" "drivers.yml"
  source $DRIVERS_DIR/install.sh
}

function request_sudo {
  clear
  echo "Requesting sudo powers upfront"
  sudo -v
}

function print_main_menu {
  clear

  echo "What do you want to setup?"
  echo "  1) Setup enviroment"
  echo "  2) Setup development projects"
  echo "  3) Install drivers"
  echo ""
  echo "  q) Quit"

  read n
  case $n in
    1)
      request_sudo
      setup_environment
      print_main_menu
      ;;
    2)
      setup_development_projects
      print_main_menu
      ;;
    3)
      request_sudo
      install_drivers
      print_main_menu
      ;;
    q)
      exit
      ;;
    *)
      echo "invalid option $REPLY";;
  esac
}

print_main_menu
