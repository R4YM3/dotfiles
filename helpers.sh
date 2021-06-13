#!/bin/bash

export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

function header {
    echo
    echo ==============================
    echo
    echo "${GREEN}$1${RESET}"
    echo
    echo ==============================
    echo
}

function subheader {
    echo
    echo "${GREEN}$1${RESET}"
    echo ------------------------------
    echo
}

function step {
    echo "${GREEN}$1${RESET}"
}

function already_installed {
    echo "Already installed: $1"
}

function install_dotfile {
  ln -sf  $1 ~/
}


TMUXINATOR_PROJECTS_DIR=~/.config/tmuxinator
function install_tmuxinator_project {
  mkdir -p $TMUXINATOR_PROJECTS_DIR
  ln -sf $1 $TMUXINATOR_PROJECTS_DIR/$2
}

function download_repository {
    # download private repositories installer (without .git because we are already in a repository)
    cd $2 && git archive --format=tar --remote=$1 HEAD | tar xf -
    cd $DOTFILES_DIR
}
