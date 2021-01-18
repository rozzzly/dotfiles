#!/usr/bin/env bash

# shellcheck source=util.sh
source ~/dotfiles/setup/util.sh

echo ""

BINNAME="${FG_Purple}lsd"

# see if it is already installed
if command -v lsd &> /dev/null; then
    PRINTY_Okay "${BINNAME}${FG_Green} is already installed"
    echo ""
    PRINTY_Info "Ensuring ${BINNAME}${FG_Cyan} is up to date"
    cargo install lsd
    install_exitcode=$?
   
    echo ""
    if [ $install_exitcode -eq 0 ] && command -v lsd &> /dev/null; then
        PRINTY_Okay "latest version of ${BINNAME}${FG_Green} installed successfully"
        echo ""
        exit 0
    else 
        PRINTY_Fail "failed to install latest version of ${BINNAME}${FG_Red}"
        echo ""
        exit 1
    fi
fi

if ! command -v cargo &> /dev/null; then
    PRINTY_Warn "${FG_Purple}rust${FG_Yellow} is not installed"
    PRINTY_Info "Installing ${FG_Purple}rust${FG_Cyan}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    install_exitcode=$?
    echo ""

    if [ $install_exitcode -eq 0 ] && command -v cargo &> /dev/null; then
        PRINTY_Okay "${FG_Purple}rust${FG_Green} installed successfully"
        echo ""
    else 
        PRINTY_Fail "failed to install ${FG_Purple}rust${FG_Red}"
        echo ""
    fi
fi

PRINTY_Info "installing ${BINNAME}${FG_Cyan}"
cargo install lsd
install_exitcode=$?

echo ""
if [ $install_exitcode -eq 0 ] && command -v lsd &> /dev/null; then
    PRINTY_Okay "${BINNAME}${FG_Green} installed successfully"
    echo ""
    exit 0
else 
    PRINTY_Fail "failed to install ${BINNAME}${FG_Red}"
    echo ""
    exit 1
fi
