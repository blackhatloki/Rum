#!/bin/bash 
. ./ENV.sh 
host=$1
#Power On a Host
ipmitool -H $host -v -I lanplus -U $USER -P $PASS  chassis power cycle
