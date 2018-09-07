#!/bin/bash
#original idea from https://raw.githubusercontent.com/selivan/ansible-ssh/master/ansible-ssh
set -x

inventory=$(ansible-inventory -i inventories/$1/hosts.ini --list)
host=$(echo "$inventory" | jq '.[] | .hosts? | .[]? ' | sort | uniq|tr -d "\"")
ansible_host=$(echo "$inventory" | jq " ._meta.hostvars[\"$host\"].ansible_host? " | grep -v '^null$' | tr -d \")
ansible_user=$(echo "$inventory" | jq " ._meta.hostvars[\"$host\"].ansible_user? " | grep -v '^null$' | tr -d \")
ansible_port=$(echo "$inventory" | jq " ._meta.hostvars[\"$host\"].ansible_port? " | grep -v '^null$' | tr -d \")
exec ssh ${ansible_user}"@"${ansible_host}
