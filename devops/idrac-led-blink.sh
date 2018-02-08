#!/bin/bash 
. ./ENV.sh 
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm setled -l 0
