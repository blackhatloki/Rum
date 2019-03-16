#!/bin/bash 
. ./ENV.sh
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm techsupreport export  -l 192.168.0.1:/mnt/home/licenses 
