#!/usr/bin/env bash

# shellcheck source=util.sh
source ~/dotfiles/setup/util.sh

echo ""

# see if it is already installed
if command -v fdfind &> /dev/null; then
    PRINTY_Okay "${FG_Purple}fd-find${FG_Green} is already installed"
    echo ""
    exit 0
fi

PRINTY_Info "installing ${FG_Purple}fd-find${FG_Cyan}"
sudo apt-get update
sudo apt-get install fd-find
install_exitcode=$?

echo ""

if [ $install_exitcode -eq 0 ]; then
    PRINTY_Okay "${FG_Purple}fd-find${FG_Green} installed successfully"
    echo ""
    exit 0
else 
    PRINTY_Fail "failed to install ${FG_Purple}fd-find${FG_Red}"
    echo ""
    exit 1
fi
