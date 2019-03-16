#!/bin/bash 
. ./ENV.sh
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm jobqueue view
# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm techsupreport export -f tsr_report.zip  -l 192.168.0.1:/mnt/home/licenses -c idrac.embedded.1
