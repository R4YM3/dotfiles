#!/bin/bash

download_repository git@bitbucket.org:R4YM3/private-repositories-installer.git $DOTFILES_PROJECTS_DIR

# source .install.sh from each project
for dir in $DOTFILES_PROJECTS_DIR/*
do
  test -d "$dir" || continue
  source $dir/install.sh
done
