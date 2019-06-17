#!/bin/bash 
. ./ENV.sh
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm  set bios.memsettings.memtest Disabled
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm  jobqueue create BIOS.Setup.1-1 -r pwrcycle -s TIME_NOW -e TIME_NA
