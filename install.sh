#!/bin/bash

# A simple script to pull my dotfiles.
os_type=$(uname -s)

install_rcm(){
    # Find Installed Package Manager
    pacman=$(which pacman)
    yay=$(which yay)
    apt=$(which apt)
    apt-get=$(which apt-get)

    # Install dependencies and git
    if [[ -f $yay ]] then
      yay -Syu rcm git
    elif [[ -f $pacman ]] then
      sudo pacman -Syu git openssh base-devel
      git clone https://aur.archlinux.org/yay-git.git
      cd yay-git
      makepkg -si
      yay -Syu
      cd ..
      rm -rf yay-git/
    elif [[ -f $apt ]]; then
      sudo apt update
      sudo apt install rcm git
    elif [[ -f $apt-get ]]; then
      sudo apt-get update
      sudo apt-get install rcm git
    fi
}

if ! which rcup >/dev/null; then
  read -p "rcm is currently not installed. Would you like to install? [Y/N]" YN
  case $YN in
      [Yy]* )  install_rcm();;
      [Nn]* ) exit;;
      * ) echo "Please answer [Y/N] or [y/n].";;
  esac
fi

# Remove oh-my-zsh
rm -rf ~/.oh-my-zsh

if [[ -d ~/.dotfiles ]]; then
  cd ~/.dotfiles
  git pull
else
  git clone []
fi

rcup -f -t $os_type -d ~/.dotfiles

zsh
