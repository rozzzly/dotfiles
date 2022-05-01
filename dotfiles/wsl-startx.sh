#!/usr/bin/env bash

export WIN_USERDIR=$(cmd.exe /c "echo %UserProfile%" | sed 's/\\/\\\\/g' | sed -e 's/\r//g')
export WIN_USERDIR_WSL=$(cmd.exe /c "echo %UserProfile%" | sed 's/\\/\\\\/g' | sed -e 's/\r//g' | xargs wslpath)
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
# checks to see if vcxsrv.exe is running on the Windows side
TASKS=$(tasklist.exe)
if ! echo "$TASKS" | grep -q "vcxsrv.exe"; then
    # makes sure there is an .XAuthority file
    # stolen from https://stackoverflow.com/a/66768217
    magiccookie=$(echo '{some-pass-phrase}'|tr -d '\n\r'|md5sum|awk '{print $1}')
    PREV_DIR=$(pwd)
    cd ~
    touch ~/.Xauthority
    xauth add $DISPLAY . $magiccookie
    cp ~/.Xauthority "$WIN_USERDIR_WSL/.Xauthority"
    cd "$PREV_DIR"
    # it's not running, so start it
    nohup "/mnt/c/Program Files/VcXsrv/vcxsrv.exe" -multiwindow -clipboard -wgl -auth "$WIN_USERDIR\\.Xauthority" >/dev/null 2>&1 & disown
    # clear screen because powerlevel10k will render twice otherwise
    echo -e "\e[H\e[J"
    echo "" # last echo never gets printed for some reason. So print something random so that the esc sequence to clear screen goes through
fi

# Set DISPLAY for xclip to use. Can't do "localhost:0" because vcxsrv is running in Windows but shell is running in WSL.
# 127.0.0.1 in WSL =/= 127.0.0.1 in Windows. They're seperate, isolated. WSL can however see windows as seperate host
# on the network. Therefore, grep /etc/resolv.conf to (from WSL's perspective) get ip of Windows side
#export LIBGL_ALWAYS_INDIRECT=true
