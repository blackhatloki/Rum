#!/bin/bash 
. ./ENV.sh
chassis=$1
switch=$2
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $chassis racadm chassisaction -m switch-$switch powercycle
