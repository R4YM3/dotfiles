#!/usr/bin/env bash

HETWEBBUREAU_DIR="$DEVELOPMENT/hetwebbureau"
HETWEBBUREAU_TMUXINATOR_PROJECTS_DIR="$HETWEBBUREAU_DIR/tmuxinator-projects/"

mkdir -p $HETWEBBUREAU_DIR

git clone https://github.com/R4YM3/dotfiles.git $HETWEBBUREAU_DIR
install_tmuxinator_project "$HETWEBBUREAU_TMUXINATOR_PROJECTS_DIR/dotfiles.yml"

git clone https://github.com/R4YM3/react-cli.git $HETWEBBUREAU_DIR
