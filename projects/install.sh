#!/bin/bash

# source .install.sh from each project
for dir in $DOTFILES_PROJECTS_DIR/*
do
  test -d "$dir" || continue
  source $dir/install.sh
done
