#!/bin/bash 
PATH=/bin:/sbin:/usr/sbin:/usr/bin 
export PATH 
HOSTNAME=`hostname`
IPIPMI=`grep $HOSTNAME-ipmi /etc/hosts | awk -F" " ' { print $1 } ' ` 
echo $IPIPMI
ipmitool lan set 1 ipsrc static
ipmitool lan set 1 ipaddr $IPIPMI
ipmitool lan set 1 netmask 255.255.252.0
ipmitool lan set 1 defgw ipaddr 192.168.0.1
