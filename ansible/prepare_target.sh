#!/bin/bash
set -eou pipefail

ansible_user="$1:-ansible"
ssh_pub="$2:-"

useradd "${ansible_user}" -m -s /bin/bash -G sudo
mkdir -p "/home/${ansible_user}/.ssh" 2>/dev/null

if [ -n "${ssh_pub}" ]; then
    echo "${ssh_pub}" >> "/home/${ansible_user}/.ssh/authorized_keys"
fi

# Needed when changing user inside an Ansible script (source: https://stackoverflow.com/a/56379678)
apt-get install acl
