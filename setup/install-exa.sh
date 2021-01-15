#!/usr/bin/env bash

source ~/dotfiles/setup/util.sh

echo ""

if command exa &> /dev/null; then
    PRINTY_Okay "${FG_Purple}exa${FG_Green} is already installed"
    echo ""
    exit 0
fi

PRINTY_Info "Installing ${FG_Purple}exa${FG_Cyan}"

sudo apt-get update
sudo apt-get install exa
install_exitcode=$?

echo ""

if [ $install_exitcode -eq 0 ]; then
    PRINTY_Okay "${FG_Purple}exa${FG_Green} installed successfully"
    echo ""
    exit 0
else
    PRINTY_Fail "failed to install ${FG_Purple}exa${FG_Red}"
    source /etc/os-release
#    if (( $(echo "$VERSION_ID == 20.04" | bc -l) )); then
    if ( version_compare "$VERSION_ID" "<" "20.10" ); then
        PRINTY_Warn "${FG_Purple}exa${FG_Yellow} is not officially availiable until 20.10. Will attempt to install from .deb manually..."
        tmp_dir=$(mktemp -d -t exa-install-XXXXXXXXXX)
        wget -P "${tmp_dir}" http://archive.ubuntu.com/ubuntu/pool/universe/r/rust-exa/exa_0.9.0-4_amd64.deb
        sudo apt-get install "${tmp_dir}/exa_0.9.0-4_amd64.deb"
        install_exitcode=$?
        echo ""
        if [ $install_exitcode -eq 0 ]; then
            PRINTY_Okay "${FG_Purple}exa${FG_Green} installed successfully"
            echo ""
            exit 0
        else
            PRINTY_Fail "failed to ${FG_Purple}exa${FG_RED}... not sure why. figure it out yourself!"
            echo ""
            exit 1
        fi
    else
        exit 1
    fi 
fi

