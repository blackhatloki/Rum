#!/bin/bash 
. ./ENV.sh 
host=$1
ipmitool -H $host -v -I lanplus -U $USER -P $PASS lan  print 1
