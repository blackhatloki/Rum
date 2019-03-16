#!/bin/bash 
. ./ENV.sh
echo $1
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm get BIOS.ProcSettings.LogicalProc 
