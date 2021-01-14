#!/usr/bin/env bash

# see if it is already installed
if command -v svn &> /dev/null; then
    echo "svn is already installed"
    exit 0
fi

echo "installing subversion"
echo ""

sudo apt-get update
sudo apt-get install subversion
install_exitcode=$?

echo ""

if [ $install_exitcode -eq 0 ]; then
    echo "installed successfully"
else 
    echo "install failed"
    exit 1
fi
