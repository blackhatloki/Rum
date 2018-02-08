#!/bin/bash
#
  echo "enabling lldp for interface: $i" ;
/sbin/lldptool set-lldp -i eth0 adminStatus=rxtx ;
/sbin/lldptool -T -i eth0 -V sysName enableTx=yes;
/sbin/lldptool -T -i eth0 -V portDesc enableTx=yes ;
/sbin/lldptool -T -i eth0 -V sysDesc enableTx=yes;
/sbin/lldptool -T -i eth0 -V sysCap enableTx=yes;
/sbin/lldptool -T -i eth0 -V mngAddr enableTx=yes;

/sbin/lldptool set-lldp -i eth2 adminStatus=rxtx ;
/sbin/lldptool -T -i eth2 -V sysName enableTx=yes;
/sbin/lldptool -T -i eth2 -V portDesc enableTx=yes ;
/sbin/lldptool -T -i eth2 -V sysDesc enableTx=yes;
/sbin/lldptool -T -i eth2 -V sysCap enableTx=yes;
/sbin/lldptool -T -i eth2 -V mngAddr enableTx=yes;
