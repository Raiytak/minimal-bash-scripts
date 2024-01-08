#!/bin/bash
# set -eEou pipefail

trap sig_handler SIGUSR1

sig_count=0

sig_handler(){
    ((++sig_count))
    printf "SIGUSR1 received $sig_count time(s).\n"
    if [[ "$sig_count" -eq 3 ]]; then
        printf "Exiting\n"
        exit 0
    fi
}

while true; do {
    kill -SIGUSR1 $$
    sleep 1
}
done
