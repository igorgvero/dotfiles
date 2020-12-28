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
  if type xcode-select >&- && xpath=$( xcode-select --print-path ) && test -d "${xpath}" && test -x "${xpath}" ; then
    echo "Xcode CLI Tools are installed"
  else
    echo "Installing Xcode Command Line Tools"
    xcode-select --install
  fi
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