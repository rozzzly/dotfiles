#!/usr/bin/env bash

source ~/dotfiles/setup/util.sh

echo ""

# attempt to load nvm if it exists
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if command -v nvm &> /dev/null; then
    PRINTY_Warn "nvm is already installed"
    echo ""
else
    if [ -f "$HOME/.bashrc" ]; then
        BASH_PROFILE="$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; then
        BASH_PROFILE="$HOME/.bash_profile"
    elif [ -f "$HOME/.profile" ]; then
        BASH_PROFILE="$HOME/.profile"
    else
        PRINTY_Fail "could find ~/.bashrc, ~/.bash_profile, or ~/.profile to inject fallback-nvm handler into"
        exit 1
    fi

    PRINTY_Info "Installing nvm"

    # Don't worry about the static vemver (ie: v0.37.2) in this curl request this script
    # just clones the repo so that the latest version is always installed
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | PROFILE="$BASH_PROFILE" bash



    # load nvm
    NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    if ! command -v nvm &> /dev/null; then
        PRINTY_Fail "nvm install failed"
        echo ""
        exit 127
    fi

    PRINTY_Okay "nvm installed successfully"
    echo ""
fi

PRINTY_Info "installing node v8"
nvm install 8
echo ""

PRINTY_Info "installing node v12"
nvm install 12
echo ""

PRINTY_Info "installing node v14"
nvm install 14
echo ""

PRINTY_Info "installing node v15"
nvm install 15
echo ""

PRINTY_Info "aliasing node v15 as default"
nvm alias default 15
echo ""

PRINTY_Okay "nvm setup complete!"
echo ""
