#!/usr/bin/env bash

# shellcheck source=util.sh
source ~/dotfiles/setup/util.sh

echo ""

UPDATE_ONLY=false

# see if it is already installed
if command -v zsh &> /dev/null; then
    PRINTY_Warn "@ is already installed" "zsh"
    PRINTY_Info "updating to latest version of @" "zsh"
    UPDATE_ONLY=true
else
    PRINTY_Info "installing @" "zsh"
fi
sudo apt-get update
INSTALL_EXITCODE=$?

if [ $INSTALL_EXITCODE -ne 0 ]; then
    echo ""
    PRINTY_Fail "failed to resynchronize the package index"
    echo ""
    exit 1
fi

sudo apt-get install zsh
INSTALL_EXITCODE=$?
echo ""

if [ $INSTALL_EXITCODE -eq 0 ] && command -V zsh &> /dev/null; then
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "updated to latest version of @ successfully" "zsh"
    else
        PRINTY_Okay "installed @ successfully" "zsh"
    fi
    echo ""
else 
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "failed to update to latest version of @" "zsh"
    else
        PRINTY_Okay "failed to install @" "zsh"
    fi
    echo ""
    exit 1
fi

PRINTY_Info "setting default shell to @" "zsh"
sudo chsh -s "$(command -v zsh)" "$(whoami)"
echo ""

PRINTY_Okay "default shell changed to @" "zsh"
echo ""

