#!/bin/bash 
. ./ENV.sh 
host=$1
ipmitool -H $host -v -I lanplus -U $USER -P $PASS   sdr type ‘Power Supply’
