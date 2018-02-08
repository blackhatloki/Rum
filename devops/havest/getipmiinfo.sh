#!/bin/bash 
ipmiip=`ipmitool lan print 1 | grep "IP Address  "  | awk -F":" ' { print $2 } '`
ipmism=`ipmitool lan print 1 | grep "Subnet Mask "  | awk -F":" ' { print $2 } '`
ipmimc=`ipmitool lan print 1 | grep "MAC Address "  | awk -F" " ' { print $4 } '`
ipmigw=`ipmitool lan print 1 | grep "Default Gateway IP " | awk -F":" ' { print $2 } '`
echo $ipmiip $ipmism $ipmimc $ipmigw
