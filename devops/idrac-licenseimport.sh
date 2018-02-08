#!/bin/bash 
. ./ENV.sh
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm license export -f $1.LicenseFile.xml  -l 192.168.0.1:/mnt/home/licenses -c idrac.embedded.1
# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm license export -f $1.LicenseFile.xml  -l 172.16.0.1/home/teague/licenses  -c idrac.embedded.1
