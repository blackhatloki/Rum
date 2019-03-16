#!/bin/bash 
. ./ENV.sh
echo $1
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm get BIOS.ProcSettings.LogicalProc 
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set BIOS.ProcSettings.LogicalProc Disabled 
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm jobqueue create BIOS.Setup.1-1 -r pwrcycle -s TIME_NOW -e TIME_NA
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm get BIOS.ProcSettings.LogicalProc 
