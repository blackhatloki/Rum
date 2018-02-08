#!/bin/bash 

. ./ENV.sh
chassis=$1

sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $chassis racadm getniccfg 
