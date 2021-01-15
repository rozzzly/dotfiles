#!/usr/bin/env bash

# Reset and Invert
PRETTY_Reset='\033[0m'
PRETTY_Invert='\033[7m'
PRETTY_Uninvert='\033[27m'
# Regular Colors
FG_Black='\033[0;30m'
FG_Red='\033[0;31m'
FG_Green='\033[0;32m'
FG_Yellow='\033[0;33m'
FG_Blue='\033[0;34m'
FG_Purple='\033[0;35m'
FG_Cyan='\033[0;36m'
FG_White='\033[0;37m'
# Background
BG_Black='\033[40m'
BG_Red='\033[41m'
BG_Green='\033[42m'
BG_Yellow='\033[43m'
BG_Blue='\033[44m'
BG_Purple='\033[45m'
BG_Cyan='\033[46m'
BG_White='\033[47m'
# Log tags
PRETTY_Info="${FG_Cyan}${PRETTY_Invert} < Info > ${PRETTY_Reset}"
PRINTY_Info () {
    echo -e "${PRETTY_Info} ${FG_Cyan}$1${PRETTY_Reset}"
}
PRETTY_Okay="${FG_Green}${PRETTY_Invert} < Okay > ${PRETTY_Reset}"
PRINTY_Okay () {
    echo -e "${PRETTY_Okay} ${FG_Green}$1${PRETTY_Reset}"
}
PRETTY_Fail="${FG_Red}${PRETTY_Invert} < Fail > ${PRETTY_Reset}"
PRINTY_Fail () {
    echo -e "${PRETTY_Fail} ${FG_Red}$1${PRETTY_Reset}"
}
PRETTY_Warn="${FG_Yellow}${PRETTY_Invert} < Warn > ${PRETTY_Reset}"
PRINTY_Warn () {
    echo -e "${PRETTY_Warn} ${FG_Yellow}$1${PRETTY_Reset}"
}

