#!/bin/bash 
. ./ENV.sh
chassis=$1
node=$2
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $chassis racadm serveraction -m server-$node powerup
