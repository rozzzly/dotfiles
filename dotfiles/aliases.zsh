#!/usr/bin/env zsh

alias ls="lsd -lA --color=always --date +\"%m/%d/%y %H:%M\""
alias fd="fdfind"
alias less="less -r"

function hexcolor() {
    if [ "$COLORTERM" = "truecolor" ]; then; echo "$2"; else; echo "$1"; fi
}


# prints swatches of all 256 ASCII colors with the following permutations for each color
#   FG: Black   BG: <color>
#   FG: White   BG: <color>
#   FG: <color> BG: Black
#   FG: <color> BG: White
# stolen from https://askubuntu.com/a/1260375
function printcolors() {
    for i in {0..255} ; do
        # Black FG on color BG
        printf "\e[30;48;5;%sm%4d " "$i" "$i"

        # White FG on color BG
        printf "\e[97m%4d " "$i"

        # Color FG on black BG
        printf "\e[40;38;5;%sm%4d " "$i" "$i"

        # Color FG on white BG
        printf "\e[107m%4d " "$i"

        # Check whether to print new line
        #[ $(( ($i +  1) % 4 )) == 0 ] && set1=1 || set1=0
        #[ $(( ($i - 15) % 6 )) == 0 ] && set2=1 || set2=0
        #if ( (( set1 == 1 )) && (( i <= 15 )) ) || ( (( set2 == 1 )) && (( i > 15 )) ); then
        #if (( ( $i  % 4 ) == 0 )) && (( $i > 0 )); then
        if (( ( ( $i + 1 )  % 4 ) == 0 )); then
            printf "\e[0m\n";
        else
            printf "\e[0m    --    "
        fi
    done
}

