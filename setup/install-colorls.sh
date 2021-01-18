#!/usr/bin/env bash

if ! command -v colorls &> /dev/null; then
    # ensure ruby is installed
    if ! command -v ruby &> /dev/null; then
        echo "ruby is not installed. Installing now..."
        echo ""

        sudo apt-get upgrade
        sudo apt-get install ruby ruby-dev

        if ! command -v gem &> /dev/null; then
            echo "ruby install unsuccessful? can't find gem"
            exit 127
        fi 
    fi

    sudo gem install colorls

    if [ $? -eq 0 ]; then
        echo "installed successfully"
    else 
        echo "failed to install colorls. Probably missing a dep like ruby-dev"
        exit 1
    fi
fi
