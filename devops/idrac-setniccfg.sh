#!/bin/bash 
. ./ENV.sh
ip=$2 
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1  racadm  –s $ip  255.255.252.0 192.168.0.1
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1  racadm getconfig
