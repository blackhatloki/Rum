#!/bin/bash 

. ./ENV.sh
chassis=$1
IP=$2
NM=$3
GW=$4
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $chassis racadm getniccfg 
echo "sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $chassis racadm setniccfg -s $IP $NM $GW"
# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $chassis racadm setniccfg -s $IP $NM $GW
