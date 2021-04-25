#!/usr/bin/env bash

# shellcheck source=util.sh
source ~/dotfiles/setup/util.sh

echo ""

UPDATE_ONLY=false

if ! is_debian_based && ! is_mac; then
    PRINTY_Fail "Unsupported platform / enviroment. Currently only debian (ubuntu, including WSL) and macOS supported."
    exit 1
fi

# see if it is already installed
if command -v fasd &> /dev/null; then
    PRINTY_Warn "@ is already installed" "fasd"
    PRINTY_Info "updating to latest version of @" "fasd"
    UPDATE_ONLY=true
else
    if is_debian_based; then
        if ! has_ppa "aacebedo/fasd"; then
            PRINTY_Info "adding @" "ppa:aacebedo/fasd"
            sudo add-apt-repository ppa:aacebedo/fasd
            echo ""

        fi
    fi
    PRINTY_Info "installing @" "fasd"
fi

if is_mac; then
    brew update
    UPDATE_EXITCODE=$?
elif is_debian_based; then
    sudo apt-get update
    UPDATE_EXITCODE=$?
fi

if [ $UPDATE_EXITCODE -ne 0 ]; then
    echo ""
    PRINTY_Fail "failed to resynchronize the package index"
    echo ""
    exit 1
fi

if is_mac; then
    brew install fasd
    INSTALL_EXITCODE=$?
elif is_debian_based; then
    sudo apt-get install fasd
    INSTALL_EXITCODE=$?
fi

echo ""

if [ $INSTALL_EXITCODE -eq 0 ] && command -V fasd &> /dev/null; then
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "updated to latest version of @ successfully" "fasd"
    else
        PRINTY_Okay "installed @ successfully" "fasd"
    fi
    echo ""
    exit 0
else
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "failed to update to latest version of @" "fasd"
    else
        PRINTY_Okay "failed to install @" "fasd"
    fi
    echo ""
    exit 1
fi
