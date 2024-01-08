#!/bin/bash
# set -eEou pipefail

# $' is necessary to escape the single quote "'" from the string
trap $'printf "*interrupted with an \'exit 1\'*\n"' EXIT
trap $'printf "\n*interrupted by SIGINT*\n"; exit 1' SIGINT

while true; do {
    printf "Please press CTL+C to stop the script\n"
    sleep 1
}
done
