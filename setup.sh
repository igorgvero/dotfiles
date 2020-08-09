#!/usr/bin/env bash

# Bash symlinking for Codespaces
if [ "$CODESPACES" == "true" ]
then
  echo "CodeSpaces environment detected"
  ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
else
# Bash symlinking for generic environments
  echo "Generic environment detected"
  ln -s ~/Repos/dotfiles/bash/.bashrc ~/.bashrc
fi
