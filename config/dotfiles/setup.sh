#!/bin/bash

source ./helpers.sh

FILES="$DOTFILES_DIR/config/dotfiles/files"

install_dotfile "$FILES/.ackrc"
install_dotfile "$FILES/.aliases"
install_dotfile "$FILES/.ctags"
install_dotfile "$FILES/.curlrc"
install_dotfile "$FILES/.editorconfig"
install_dotfile "$FILES/.exports"
install_dotfile "$FILES/.functions"
install_dotfile "$FILES/.gitattributes"
install_dotfile "$FILES/.gitconfig"
install_dotfile "$FILES/.gitignore"
install_dotfile "$FILES/.hushlogin"
install_dotfile "$FILES/.inputrc"
install_dotfile "$FILES/.screenrc"
install_dotfile "$FILES/.wgetrc"
