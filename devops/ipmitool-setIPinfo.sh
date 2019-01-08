#!/bin/bash 
. ./ENV.sh 
host=$1
ipipmi=$2
netmask=$3
gw=$4
ipmitool -H $host -v -I lanplus -U $USER -P $PASS lan set 1 ipsrc static
ipmitool -H $host -v -I lanplus -U $USER -P $PASS lan set 1 ipaddr $1
ipmitool -H $host -v -I lanplus -U $USER -P $PASS lan set 1 netmask $2
ipmitool -H $host -v -I lanplus -U $USER -P $PASS lan set 1 defgw ipaddr $3
ipmitool -H $host -v -I lanplus -U $USER -P $PASS lan  print 1
