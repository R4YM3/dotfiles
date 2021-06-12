#!/bin/bash

for dir in $DOTFILES_PROJECTS_DIR/*
do
  test -d "$dir" || continue
  chmod +x $dir/install.sh
  source $dir/install.sh
done
