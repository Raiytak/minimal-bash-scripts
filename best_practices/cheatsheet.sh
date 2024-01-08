#!/bin/bash

# == Short version ==
set -eou pipefail

# == Long version ==
set -o errexit # Exit script on error, execpt if handled like "err | handling"
set -o unset # Error when unset variable
set -o pipefail # Error inside a pipe is propagated


# Use long parameter notation
# Avoid:
rm -rf -- "${dir}"
# Good:
rm --recursive --force -- "${dir}"

# Explicit  scopes
(
    cd "${foo}"
    [...]
)
# Or use tools for it
pushd "${foo}"
[...]
popd

# To start a job in background
nohup foo | cat &

## +++ VARIABLES +++
local_variables=lowercase
GLOBAL_VARIABLES=UPPERCASE

# 1. For readability, enclose variables with brackets
# 2. Variables should be quoted. This prevents undesireable side effects from variable expansion
foo="${bar}"

# 1. Prefer local variables inside a function
# 2. Global variables should be read-only


### ++ INPUTS ++
# Positional parameters should be checked
# Arguments of functions should not be checked

substitution=$(ls -la) # Always use
bad_substitution=`ls -la`

## OUTPUTS and REDIRECTIONS
printf "'printf' is better than 'echo' (more portable, more control over output)\n"

error() {
    printf "Show your error in STDERR\n" 1>&2
}
error

# Sudo rights only apply to the command they target, not the redirection
# this won't work:
sudo printf "..." > /root/some_file

# this will:
printf "..." | sudo tee /root/some_file > /dev/null


## ++ FUNCTIONS ++
# Use Single Responsibility Principle (https://en.wikipedia.org/wiki/Single_responsibility_principle)


# ++ CLEANUP CODE ++
# Should be used to make sure borrowed resources are released
finish() {
    result=$?
    # Your cleanup code
    exit ${result}
}
trap finish EXIT

error() {
    result=$?
    # Your handling of error
    # exit ${result} # optional
}
trap error ERR

scratch=$(mktemp -d -t tmp.XXXXXXXXXX)
finish() {
    result=$?
    # Your cleanup code
    rm -rf "$scratch"
    exit ${result}
}
trap finish EXIT

function finish {
    # re-start service
    sudo something start
}
trap finish EXIT
sudo something stop


## ++ EXTRA TOOLS ++
# https://www.shellcheck.net/

# Example best practices
# https://bertvv.github.io/cheat-sheets/Bash.html
