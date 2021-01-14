#!/usr/bin/env zsh

if command -v nvm &> /dev/null; then
    echo "nvm is not is not installed yet"
    exit -127
fi

echo "installing desired versions of nvm"
echo ""
echo "installing node v8.*.*"
echo ""
nvm install 8
echo ""
echo "installing node v12.*.*"
nvm install 12
echo ""
echo "installing node v14.*.*"
nvm install 14
echo ""
echo "installing node v15.*.*"
echo ""
nvm install 15
echo ""
echo "aliasing node v15 as default"
echo ""
nvm alias default 15
echo ""
echo "nvm all ready to go!"
