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
    if [ -z "$2" ]; then
        echo -e "${PRETTY_Info} ${FG_Cyan}$1${PRETTY_Reset}"
    else
        echo -e "${PRETTY_Info} ${FG_Cyan}${1//@/$FG_Purple$2$FG_Cyan}${PRETTY_Reset}"
    fi
}
PRETTY_Okay="${FG_Green}${PRETTY_Invert} < Okay > ${PRETTY_Reset}"
PRINTY_Okay () {
    if [ -z "$2" ]; then
        echo -e "${PRETTY_Okay} ${FG_Green}$1${PRETTY_Reset}"
    else
        echo -e "${PRETTY_Okay} ${FG_Green}${1//@/$FG_Purple$2$FG_Green}${PRETTY_Reset}"
    fi
}
PRETTY_Fail="${FG_Red}${PRETTY_Invert} < Fail > ${PRETTY_Reset}"
PRINTY_Fail () {
    if [ -z "$2" ]; then
        echo -e "${PRETTY_Fail} ${FG_Red}$1${PRETTY_Reset}"
    else
        echo -e "${PRETTY_Fail} ${FG_Red}${1//@/$FG_Purple$2$FG_Red}${PRETTY_Reset}"
    fi
}
PRETTY_Warn="${FG_Yellow}${PRETTY_Invert} < Warn > ${PRETTY_Reset}"
PRINTY_Warn () {
    if [ -z "$2" ]; then
        echo -e "${PRETTY_Warn} ${FG_Yellow}$1${PRETTY_Reset}"
    else
        echo -e "${PRETTY_Warn} ${FG_Yellow}${1//@/$FG_Purple$2$FG_Yellow}${PRETTY_Reset}"
    fi
}

# for comparing semvers 
# stolen from https://stackoverflow.com/a/65048470
version_compare() {
    _largest_version "$1" "$3"; _cmp="$(printf '%s' "$?")"

    # Check for valid responses or bail early
    case "$_cmp" in
        1|0|2) :;;
        *) _die "$_cmp" 'version comparison failed';;
    esac

    # The easy part
    case "$2" in
        'lesser_than'|'-lt'|'<')
            [ "$_cmp" = '2' ] && return 0
            ;;
        'lesser_or_equal'|'-le'|'<=')
            [ "$_cmp" = '0' ] && return 0
            [ "$_cmp" = '2' ] && return 0
            ;;
        'greater_than'|'-gt'|'>')
            [ "$_cmp" = '1' ] && return 0
            ;;
        'greater_or_equal'|'-ge'|'>=')
            [ "$_cmp" = '1' ] && return 0
            [ "$_cmp" = '0' ] && return 0
            ;;
        'equal'|'-eq'|'==')
            [ "$_cmp" = '0' ] && return 0
            ;;
        'not_equal'|'-ne'|'!=')
            [ "$_cmp" = '1' ] && return 0
            [ "$_cmp" = '2' ] && return 0
            ;;
        *) _die 7 'Unknown operatoration called for version_compare().';;
    esac
    return 1
}

##
# Print a formatted (critical) message and exit with status.
#
# **Usage:** _die [exit_status] message
#
# - exit_status: exit code to use with script termination (default: 1)
# - message: message to print before terminating script execution
##
_die() {
        # If first argument was an integer, use as exit_status
        if [ "$1" -eq "$1" ] 2>/dev/null; then
                _exit_status="$1"; shift
        else
                _exit_status=1
        fi

        printf '*** CRITICAL: %s ***\n' "$1"
        exit "$_exit_status"
}

##
# Compare two versions.
# Check if one version is larger/smaller/equal than/to another.
#
# **Usage:** _largest_version ver1 ver2
#
# Returns: ($1 > $2): 1 ; ($1 = $2): 0 ; ($1 < $2): 2
# [IOW- 1 = $1 is largest; 0 = neither ; 2 = $2 is largest]
##
_largest_version() (
    # Value used to separate version components
    VERSION_SEPARATOR="${VERSION_SEPARATOR:-.}"

    for _p in "$1" "$2"; do
        [ "$(printf %.1s "$_p")" = "$VERSION_SEPARATOR" ] &&
            _die 7 'invalid version pattern provided'
    done

    # Split versions on VER_SEP into int/sub
    _v="$1$2"
    _v1="$1"
    _s1="${1#*$VERSION_SEPARATOR}"
    if [ "$_v1" = "$_s1" ]; then
        _s1=''
        _m1="$_v1"
    else
        _m1="${1%%$VERSION_SEPARATOR*}"
    fi
    _v2="$2"
    _s2="${2#*$VERSION_SEPARATOR}"
    if [ "$_v2" = "$_s2" ]; then
        _s2=''
        _m2="$_v2"
    else
        _m2="${2%%$VERSION_SEPARATOR*}"
    fi

    # Both are equal
    [ "$_v1" = "$_v2" ] && return 0

    # Something is larger than nothing (30 < 30.0)
    if [ -n "$_v1" ] && [ ! -n "$_v2" ]; then
        return 1
    elif [ ! -n "$_v1" ] && [ -n "$_v2" ]; then
        return 2
    fi

    # Check for invalid
    case "$_m1$_m2" in
        *[!0-9]*)
            _die 7 'version_compare called with unsupported version type'
            ;;
    esac

    # If a ver_sep is present
    if [ "${_v#*$VERSION_SEPARATOR}" != "$_v" ]; then
        # Check for a larger "major" version number
        [ "$_m1" -lt "$_m2" ] && return 2
        [ "$_m1" -gt "$_m2" ] && return 1

        # Compare substring components
        _largest_version "$_s1" "$_s2"; return "$?"
    else
        # Only integers present; simple integer comparison
        [ "$_v1" -lt "$_v2" ] && return 2
        [ "$_v1" -gt "$_v2" ] && return 1
    fi
)
