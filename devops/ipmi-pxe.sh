#!/bin/bash
IPMI=$1
ipmitool -I lan -H $IPMI  -U root -f ./pfile  chassis bootparams set  bootflag pxe
ipmitool -I lan -H $IPMI  -U root -f ./pfile  chassis power cycle
# ipmitool -I lan -H $IPMI  -U root -f pfile -a chassis bootparam set bootflag pxe
# ipmitool -I lan -H $IPMI  -U root -f pfile -a chassis power cycle
