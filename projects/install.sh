#!/bin/bash

# source / execute in each project ./install.sh
for dir in $DOTFILES_PROJECTS_DIR/*
do
  test -d "$dir" || continue
  source $dir/install.sh
done
