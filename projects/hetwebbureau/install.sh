#!/bin/bash

header "Install project: hetwebbureau"

HETWEBBUREAU_DIR="$DEVELOPMENT_DIR/hetwebbureau"

mkdir -p $HETWEBBUREAU_DIR

git clone https://github.com/R4YM3/dotfiles.git $HETWEBBUREAU_DIR/dotfiles
install_tmuxinator_project "$HETWEBBUREAU_DIR/dotfiles/tmuxinator.yml" "dotfiles.yml"

git clone https://github.com/R4YM3/react-cli.git "$HETWEBBUREAU_DIR/react-cli"
install_tmuxinator_project "$HETWEBBUREAU_DIR/react-cli/tmuxinator.yml" "react-cli.yml"

git clone https://github.com/R4YM3/webcli.git "$HETWEBBUREAU_DIR/webcli"
install_tmuxinator_project "$HETWEBBUREAU_DIR/webcli/tmuxinator.yml" "webcli.yml"

git clone https://github.com/R4YM3/webcli-interpreter.git "$HETWEBBUREAU_DIR/webcli-interpreter"
install_tmuxinator_project "$HETWEBBUREAU_DIR/webcli-interpreter/tmuxinator.yml" "webcli-interpreter.yml"

git clone https://github.com/R4YM3/webcli-todo.git "$HETWEBBUREAU_DIR/webcli-todo"
install_tmuxinator_project "$HETWEBBUREAU_DIR/webcli-todo/tmuxinator.yml" "webcli-todo.yml"

git clone git@bitbucket.org:R4YM3/private-repositories-installer.git "$HETWEBBUREAU_DIR/private-repositories-installer"
install_tmuxinator_project "$HETWEBBUREAU_DIR/private-repositories-installer/tmuxinator.yml" "private-repositories-installer.yml"

git clone git@bitbucket.org:R4YM3/private-drivers-installer.git "$HETWEBBUREAU_DIR/private-drivers-installer"
install_tmuxinator_project "$HETWEBBUREAU_DIR/private-drivers-installer/tmuxinator.yml" "private-drivers-installer.yml"


