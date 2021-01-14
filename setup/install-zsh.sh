#!/usr/bin/env bash

if ! command -v zsh &> /dev/null; then
    echo "zsh already installed"
else
    echo "zsh not yet installed. Installing now..."
    echo ""
    sudo apt-get update
    sudo apt-get install zsh
fi

echo ""
echo "starting next step"
echo ""


echo "changing default shell"
sudo chsh -s $(which zsh) $(whoami)

