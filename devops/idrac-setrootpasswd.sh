#!/bin/bash 
. ./ENV.sh
sshpass -p $DPASS ssh -n -o StrictHostKeyChecking=no -l $USER $1  racadm get idrac.users.2.username
sshpass -p $DPASS ssh -n -o StrictHostKeyChecking=no -l $USER $1  racadm set idrac.users.2.password $PASS
