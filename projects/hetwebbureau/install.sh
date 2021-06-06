#!/bin/bash

header "Install project: hetwebbureau"

HETWEBBUREAU_DIR="$DEVELOPMENT_DIR/hetwebbureau"
HETWEBBUREAU_TMUXINATOR_PROJECTS_DIR="$DOTFILES_DIR/projects/hetwebbureau/tmuxinator-projects"

mkdir -p $HETWEBBUREAU_DIR

git clone https://github.com/R4YM3/dotfiles.git $HETWEBBUREAU_DIR/dotfiles
echo "$HETWEBBUREAU_TMUXINATOR_PROJECTS_DIR/dotfiles.yml"
install_tmuxinator_project "$HETWEBBUREAU_TMUXINATOR_PROJECTS_DIR/dotfiles.yml"

git clone https://github.com/R4YM3/react-cli.git $HETWEBBUREAU_DIR/react-cli
