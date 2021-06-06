
#!/usr/bin/env bash
export DOTFILES_DIR
export DEVELPMENT_DIR

# DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEVELOPMENT_DIR=~/DevelopmentA

source ./helpers.sh

function install_linux_drivers {
  source ./drivers/linux/enterprise/install.sh
}

function setup_environment {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    setup_linux
    setup_generic
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    # setup_macos
    setup_generic
  else
    echo "Error: not able to setup environment: unknown OS"
  fi
}

function setup_linux {
  source ./config/folders/setup.sh   # TODO: required ?
  source ./install/apt.sh
  source ./install/snap.sh
  source ./config/gnome/setup.sh # TODO: requires wallpaper
}

function setup_macos {
  #source ./install/xcode.sh
  #source ./install/brew.sh
  #source ./install/brew-cask.sh
  #source ./install/mas.sh
  source ./config/macos/setup.sh
}

function setup_generic {
  source ./config/zsh/setup.sh
  source ./config/dotfiles/setup.sh
  source ./config/zsh/setup.sh
  source ./install/node.sh
  source ./config/nvim/setup.sh
  source ./config/tmux/setup.sh
  source ./config/tmuxinator/setup.sh
}

function setup_development_projects {
  source ./projects/hetwebbureau/install.sh
}

function init_menu {
echo "select the operation ************"
echo "  1) Install Linux drivers"
echo "  2) Setup enviroment"
echo "  3) Setup development projects"
echo "  4) Quit"

read n
case $n in
  1)
    sudo -v
    install_linux_drivers
    ;;
  2)
    sudo -v
    setup_environment

    if [[ "$OSTYPE" == "darwin"* ]]; then
      # zsh as default shell
      sudo echo /usr/local/bin/zsh >> /etc/shells
      echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
      chsh -s /usr/local/bin/zsh
    fi

    ;;
  3)
    setup_development_projects
    ;;
  4)
    exit
    ;;
  *)
    echo "invalid option $REPLY";;
esac
}

init_menu

