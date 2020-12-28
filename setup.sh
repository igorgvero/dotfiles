#!/usr/bin/env bash

# Bash symlinking for Codespaces
# -----------------------------------------------------------------------------
if [ "$CODESPACES" == "true" ]
then
  echo "CodeSpaces environment detected"
  CodeSpacesDotfilesConfig
fi

# Parameters
while true; do
  case "$1" in
    -i|--init)
      echo "Install/initialize software"
      DotfilesConfig
      InstallSoftware
      shift
    ;;
    -d|--dotfiles)
     DotfilesConfig
  *)
    break
    ;;
  esac
done

InstallSoftware {
  echo "Installing Xcode Command Line Tools"
  xcode-select --install
  echo "Installing Brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew bundle --file ./Brewfile
}

CodeSpacesDotfilesConfig {
  echo "Dotsourcing config files"
  rm ~/.bashrc
  ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
}

DotfilesConfig {
  echo "Generic environment detected"
  ln -s ~/Repos/dotfiles/bash/.bashrc ~/.bashrc
}