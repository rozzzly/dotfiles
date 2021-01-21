#!/usr/bin/env bash

# shellcheck source=util.sh
source ~/dotfiles/setup/util.sh

echo ""
UPDATE_ONLY=false
# see if it is already installed
if command -v lsd &> /dev/null; then
    PRINTY_Warn "@ is already installed" "lsd"
    PRINTY_Info "updating to latest version of @" "lsd"
    UPDATE_ONLY=true
else
    PRINTY_Info "installing @" "lsd"
fi

if ! command -v cargo &> /dev/null; then
    PRINTY_Warn "@ is not installed" "rust"
    PRINTY_Info "installing @" "rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    INSTALL_EXITCODE=$?
    echo ""

    if [ $INSTALL_EXITCODE -eq 0 ] && command -v cargo &> /dev/null; then
        PRINTY_Okay "installed @ successfully" "rust"
        echo ""
    else 
        PRINTY_Fail "failed to install @" "rust"
        echo ""
        exit 1
    fi
fi


cargo install lsd
INSTALL_EXITCODE=$?
echo ""

if [ $INSTALL_EXITCODE -eq 0 ] && command -V lsd &> /dev/null; then
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "updated to latest version of @ successfully" "lsd"
    else
        PRINTY_Okay "installed @ successfully" "lsd"
    fi
    echo ""
    exit 0
else 
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "failed to update to latest version of @" "lsd"
    else
        PRINTY_Okay "failed to install @" "lsd"
    fi
    echo ""
    exit 1
fi