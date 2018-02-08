#!/bin/bash 
playbook=$1
groups=$2 
ansible-playbook $playbook  -i inventory --limit $groups -k -u root
