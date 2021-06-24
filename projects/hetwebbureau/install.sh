#!/bin/bash

header "Install project: hetwebbureau"

HETWEBBUREAU_DIR="$DEVELOPMENT_DIR/hetwebbureau"

mkdir -p $HETWEBBUREAU_DIR

git clone https://github.com/R4YM3/dotfiles.git $HETWEBBUREAU_DIR/dotfiles
install_tmuxinator_project "$HETWEBBUREAU_DIR/dotfiles/tmuxinator.yml" "dotfiles.yml"

git clone https://github.com/R4YM3/react-cli.git "$HETWEBBUREAU_DIR/react-cli"
install_tmuxinator_project "$HETWEBBUREAU_DIR/react-cli/tmuxinator.yml" "react-cli.yml"

git clone https://github.com/R4YM3/web-cli.git "$HETWEBBUREAU_DIR/web-cli"
install_tmuxinator_project "$HETWEBBUREAU_DIR/web-cli/tmuxinator.yml" "web-cli.yml"

git clone https://github.com/R4YM3/web-cli-interpreter.git "$HETWEBBUREAU_DIR/web-cli-interpreter"
install_tmuxinator_project "$HETWEBBUREAU_DIR/web-cli-interpreter/tmuxinator.yml" "web-cli-interpreter.yml"

git clone git@bitbucket.org:R4YM3/private-repositories-installer.git "$HETWEBBUREAU_DIR/private-repositories-installer"
install_tmuxinator_project "$HETWEBBUREAU_DIR/private-repositories-installer/tmuxinator.yml" "private-repositories-installer.yml"

git clone git@bitbucket.org:R4YM3/private-drivers-installer.git "$HETWEBBUREAU_DIR/private-drivers-installer"
install_tmuxinator_project "$HETWEBBUREAU_DIR/private-drivers-installer/tmuxinator.yml" "private-drivers-installer.yml"
