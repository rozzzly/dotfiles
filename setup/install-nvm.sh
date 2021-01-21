#!/usr/bin/env bash

source ~/dotfiles/setup/util.sh

echo ""

# attempt to load nvm if it exists
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

UPDATE_ONLY=false
if command -v nvm &> /dev/null; then
    PRINTY_Warn "@ is already installed" "nvm"
    PRINTY_Info "updating to latest version of @" "nvm"
    UPDATE_ONLY=true
else
    PRINTY_Info "installing @" "nvm"
fi

# find ~/.bashrc orwhatever for nvm to inject itelf into so that it doesn't touch .zshrc which already has its 
# own nvm injection 
if [ -f "$HOME/.bashrc" ]; then
    BASH_PROFILE="$HOME/.bashrc"
elif [ -f "$HOME/.bash_profile" ]; then
    BASH_PROFILE="$HOME/.bash_profile"
elif [ -f "$HOME/.profile" ]; then
    BASH_PROFILE="$HOME/.profile"
else
    PRINTY_Fail "could find ~/.bashrc, ~/.bash_profile, or ~/.profile to inject fallback nvm handler into"
    exit 1
fi

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | PROFILE="$BASH_PROFILE" bash
INSTALL_EXITCODE=$?

# load nvm
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
echo ""

if [ $INSTALL_EXITCODE -ne 0 ] || ! command -v nvm &> /dev/null; then
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Fail "failed to update to latest version of @" "nvm"
    else
        PRINTY_Fail "failed to install @" "nvm"
    fi
    echo ""
    exit 127
fi 

if [ "$UPDATE_ONLY" = true ]; then
    PRINTY_Okay "updated to latest version of @ successfully" "nvm"
else
    PRINTY_Okay "installed @ successfully" "nvm"
fi
echo ""


PRINTY_Info "installing @" "node v8"
nvm install 8
echo ""

PRINTY_Info "installing @" "node v12"
nvm install 12
echo ""

PRINTY_Info "installing @" "node v14"
nvm install 14
echo ""

PRINTY_Info "installing @" "node v15"
nvm install 15
echo ""

PRINTY_Info "aliasing @ as default" "node v15"
nvm alias default 15
echo ""

PRINTY_Okay "setup of @ complete!" "nvm"
echo ""

exit 0