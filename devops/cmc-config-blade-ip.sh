#!/bin/bash 

. ./ENV.sh
chassis=$1
node=$2
ip=$3 

sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $chassis racadm config -g    cfgServerInfo -o cfgServerNicEnable 1 -i $node
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $chassis racadm getconfig -g cfgServerInfo -o cfgServerNicEnable -i   $node
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $chassis racadm setniccfg -m server-$node -s $ip 255.255.252.0  192.168.0.1 
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $chassis racadm getniccfg -m server-$node
