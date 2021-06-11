#!/bin/bash

header "Install project: hetwebbureau"

HETWEBBUREAU_DIR="$DEVELOPMENT_DIR/hetwebbureau"

mkdir -p $HETWEBBUREAU_DIR

git clone https://github.com/R4YM3/dotfiles.git $HETWEBBUREAU_DIR/dotfiles
install_tmuxinator_project "$HETWEBBUREAU_DIR/dotfiles/tmuxinator.yml" "dotfiles.yml"

git clone https://github.com/R4YM3/react-cli.git "$HETWEBBUREAU_DIR/react-cli"
install_tmuxinator_project "$HETWEBBUREAU_DIR/react-cli/tmuxinator.yml" "react-cli.yml"
