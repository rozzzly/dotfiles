#!/usr/bin/env bash

# checks to see if vcxsrv.exe is running on the Windows side
TASKS=$(tasklist.exe)
if ! echo "$TASKS" | grep -q "vcxsrv.exe"; then
    # it's not running, so start it
    "/mnt/c/Program Files/VcXsrv/xlaunch.exe" -run ~/.config/vcxsrv.xlaunch
fi

# Set DISPLAY for xclip to use. Can't do "localhost:0" because vcxsrv is running in Windows but shell is running in WSL. 
# 127.0.0.1 in WSL =/= 127.0.0.1 in Windows. They're seperate, isolated. WSL can however see windows as seperate host
# on the network. Therefore, grep /etc/resolv.conf to (from WSL's perspective) get ip of Windows side 
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
