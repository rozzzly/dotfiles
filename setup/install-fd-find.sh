#!/usr/bin/env bash

echo ""

# shellcheck source=util.sh
source ~/dotfiles/setup/util.sh

UPDATE_ONLY=false
# see if it is already installed
if command -v svn &> /dev/null; then
    PRINTY_Warn "@ is already installed" "fd-find"
    PRINTY_Info "updating to latest version of @" "fd-find"
    UPDATE_ONLY=true
else
    PRINTY_Info "installing @" "fd-find"
fi
sudo apt-get update
INSTALL_EXITCODE=$?
if [ $INSTALL_EXITCODE -ne 0 ]; then
    echo ""
    PRINTY_Fail "failed to resynchronize the package index"
    echo ""
    exit 1
fi

sudo apt-get install fd-find
INSTALL_EXITCODE=$?
echo ""

if [ $INSTALL_EXITCODE -eq 0 ] && command -V svn &> /dev/null; then
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "updated to latest version of @ successfully" "fd-find"
    else
        PRINTY_Okay "installed @ successfully" "fd-find"
    fi
    echo ""
    exit 0
else 
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "failed to update to latest version of @" "fd-find"
    else
        PRINTY_Okay "failed to install @" "fd-find"
    fi
    echo ""
    exit 1
fi