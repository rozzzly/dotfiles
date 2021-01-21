#!/usr/bin/env bash

# shellcheck source=util.sh
source ~/dotfiles/setup/util.sh
echo ""

UPDATE_ONLY=false
# see if it is already installed
if command -v yarn &> /dev/null; then
    PRINTY_Warn "@ is already installed" "yarn"
    PRINTY_Info "updating to latest version of @" "yarn"
    echo ""
    UPDATE_ONLY=true
else
    PRINTY_Info "installing @" "yarn"
    # install the deb
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
fi


sudo apt-get update
INSTALL_EXITCODE=$?

if [ $INSTALL_EXITCODE -ne 0 ]; then
    PRINTY_Fail "failed to resynchronize the package index"
    echo ""
    exit 1
fi

# passing --no-install-recommends prevents node from being installed, we want to keep that managed by nvm
sudo apt-get install --no-install-recommends yarn
INSTALL_EXITCODE=$?

echo ""
if [ $INSTALL_EXITCODE -eq 0 ] && command -V yarn &> /dev/null; then
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "updated to latest version of @ successfully" "yarn"
    else
        PRINTY_Okay "installed @ successfully" "yarn"
    fi
    echo ""
    exit 0
else 
    if [ "$UPDATE_ONLY" = true ]; then
        PRINTY_Okay "failed to update to latest version of @" "yarn"
    else
        PRINTY_Okay "failed to install @" "yarn"
    fi
    echo ""
    exit 1
fi
