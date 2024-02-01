#!/bin/bash
set -eou pipefail

scratch=$(mktemp -d -t tmp.XXXXXXXXXX)
function finish {
    rm -rf "${user_roles_path}"/*
    rm -rf "${scratch}"
}
trap finish EXIT

repository_roles_path="${1:-$(pwd)/ansible/roles}"
user_roles_path="${HOME}/.ansible/roles"

if [ ! -d "${repository_roles_path}" ]; then
    printf "The directory 'roles' does not exist at the path: '${repository_roles_path}'\n"
    exit 1
fi
if [ ! "${repository_roles_path:0:1}" = "/" ]; then
    printf "The path you provided is not an absolute path: '${repository_roles_path}'\n"
    exit 1
fi
if [ ! "${repository_roles_path##*/}" = "roles" ]; then
    printf "The path you gave does not terminates with 'roles': '${repository_roles_path}'\n"
    exit 1
fi

pip3 install --user --upgrade ansible-lint 1>/dev/null

if [ ! -d "${user_roles_path}" ]; then
    mkdir "${user_roles_path}"
else
    rm -rf "${user_roles_path}"/*
fi
ln -s "${repository_roles_path}"/* "${user_roles_path}"

ansible-lint
