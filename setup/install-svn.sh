#!/usr/bin/env bash

# shellcheck source=util.sh
source ~/dotfiles/setup/util.sh

UPDATE_ONLY=false
# see if it is already installed
if command -v svn &> /dev/null; then
    PRINTY_Warn "@ is already installed" "svn (subversion)"
    PRINTY_Info "updating to latest version of @" "svn (subversion)"
    UPDATE_ONLY=true
else
    PRINTY_Info "installing @" "svn (subversion)"
fi

echo ""

sudo apt-get update
INSTALL_EXITCODE=$?

if [ $INSTALL_EXITCODE -ne 0 ]; then
    echo ""
    PRINTY_Fail "failed to resynchronize the package index"
    echo ""
    exit 1
fi

sudo apt-get install subversion
INSTALL_EXITCODE=$?

echo ""
if [ $INSTALL_EXITCODE -eq 0 ] && command -V svn &> /dev/null; then
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "updated to latest version of @ successfully" "svn (subversion)"
    else
        PRINTY_Okay "installed @ successfully" "svn (subversion)"
    fi
    echo ""
    exit 0
else 
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "failed to update to latest version of @" "svn (subversion)"
    else
        PRINTY_Okay "failed to install @" "svn (subversion)"
    fi
    echo ""
    exit 1
fi