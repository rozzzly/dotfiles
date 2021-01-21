#!/usr/bin/env bash

# shellcheck source=util.sh
source ~/dotfiles/setup/util.sh

echo ""

UPDATE_ONLY=false

# see if it is already installed
if command -v fzf &> /dev/null; then
    PRINTY_Warn "@ is already installed" "fzf"
    PRINTY_Info "updating to latest version of @" "fzf"
    UPDATE_ONLY=true
else
    PRINTY_Info "installing @" "fzf"
fi
sudo apt-get update
INSTALL_EXITCODE=$?

if [ $INSTALL_EXITCODE -ne 0 ]; then
    echo ""
    PRINTY_Fail "failed to resynchronize the package index"
    echo ""
    exit 1
fi

sudo apt-get install fzf
INSTALL_EXITCODE=$?
echo ""

if [ $INSTALL_EXITCODE -eq 0 ] && command -V fzf &> /dev/null; then
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "updated to latest version of @ successfully" "fzf"
    else
        PRINTY_Okay "installed @ successfully" "fzf"
    fi
    echo ""
    exit 0
else 
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "failed to update to latest version of @" "fzf"
    else
        PRINTY_Okay "failed to install @" "fzf"
    fi
    echo ""
    exit 1
fi
