#!/bin/bash

download_repository git@bitbucket.org:R4YM3/private-repositories-installer.git $PROJECTS_DIR
cd $PROJECTS_DIR && git pull

# source .install.sh from each project
for dir in $PROJECTS_DIR/*
do
  test -d "$dir" || continue
  source $dir/install.sh
done
