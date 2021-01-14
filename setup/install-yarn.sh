#!/usr/bin/env bash

# see if it is already installed
if command -v yarn &> /dev/null; then
    echo "yarn is already installed"
    exit 0
fi

echo "installing yarn"
echo ""

# install the deb
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update
# passing --no-install-recommends prevents node from being installed, we want to keep that managed by nvm
sudo apt-get install --no-install-recommends yarn
install_exitcode=$?

echo ""

if [ $install_exitcode -eq 0 ]; then
    echo "installed successfully"
else 
    echo "install failed"
    exit 1
fi
