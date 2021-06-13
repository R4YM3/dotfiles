#!/usr/bin/env bash
export DOTFILES_DIR
export DOTFILES_CONFIG_DIR
export DOTFILES_DRIVERS_DIR
export DOTFILES_PROJECTS_DIR
export DEVELPMENT_DIR

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_CONFIG_DIR="$DOTFILES_DIR/config"
DOTFILES_DRIVERS_DIR="$DOTFILES_DIR/drivers"
DOTFILES_PROJECTS_DIR="$DOTFILES_DIR/projects"
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
  source ./install/apt.sh
  source ./install/snap.sh
  source ./config/gnome/setup.sh
}

function setup_macos {
  read -p "Please login App Store to install apps from App Store,  press <enter> to continue"
  clear

  source ./install/xcode.sh
  source ./install/mas.sh
  source ./install/brew.sh
  source ./install/brew-cask.sh
  source ./config/macos/setup.sh
  source ./config/iterm.sh
}

function setup_generic {
  source ./config/zsh/setup.sh
  source ./config/dotfiles/setup.sh
  source ./install/node.sh
  source ./config/nvim/setup.sh
  source ./config/tmux/setup.sh
  source ./config/tmuxinator/setup.sh
}

function setup_development_projects {
  clear
  source ./projects/install.sh
}


function install_linux_drivers {
  mkdir -p $DOTFILES_DRIVERS_DIR
  download_repository git@bitbucket.org:R4YM3/private-drivers-installer.git $DOTFILES_DRIVERS_DIR
  install_tmuxinator_project "$DOTFILES_DRIVERS_DIR/tmuxinator.yml" "drivers.yml"
  source $DOTFILES_DRIVERS_DIR/install.sh
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
  echo "  3) Install Linux drivers"
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
      install_linux_drivers
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
