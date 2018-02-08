#!/bin/bash 

PATH=/bin:/sbin:/usr/sbin:/usr/bin
export PATHH

/bin/mst start
/bin/mst status
/bin/flint -d flint -d /dev/mst/mt4099_pciconf0 q | grep "PSID:"
