#!/bin/bash
# set -E transmist the traps to the called scripts
set -eEou pipefail

errorHandling(){
    printf "*errorHandling: Bad command detected. Return code $?*\n"
}

trap "echo *trap ERR: error in ${FUNCNAME-main context}, at line ${LINENO}*" ERR

main(){
    first
    bad_command || errorHandling
    second
    source error_handling/generate_error.sh
    third
}

first(){
    printf "Inside first\n"
}
second(){
    printf "Inside second\n"
}
third(){
    printf "Inside third\n"
}

main
