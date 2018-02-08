#!/bin/bash 
CHIP=`cat /proc/cpuinfo | grep "model name" | sort -u  | awk -F":" ' { print $2 } '  | sed -e 's/  */ /g' | sed -e 's/^ //g'`
PCPU=`cat /proc/cpuinfo | egrep "physical id" | sort -u  | wc -l`
CPU=`cat /proc/cpuinfo | grep processor | wc -l`
CORES=`cat /proc/cpuinfo | grep "cpu cores"  | sort -u  | awk -F":" ' { print $2 } '  | sed -e 's/ *//'`
# SPEED=`cat /proc/cpuinfo | grep "cpu MHz" | sort -u | awk -F":" ' { print $2 } ' | sed -e 's/ *//g'`
CACHE=`cat /proc/cpuinfo | grep "cache size" | sort -u | awk -F":" ' { print $2 } ' | sed -e 's/ *//g'`
MEMORY=`cat /proc/meminfo  | grep "MemTotal:"  | awk -F":" ' { print $2 $3 } ' | sed -e 's/ //g'`
# VENDOR=`cat /proc/cpuinfo | grep vendor_id  | sort -u | awk -F":" ' { print $2 } '  | sed -e 's/ *//g'`
CPU2=`expr $PCPU \* $CORES`
HT2=`expr $CPU2 \* 2 `
if [ $HT2 -eq $CPU ] ; then 
   HT="enable" 
else
   HT="disable"
fi
## echo "`hostname`:Chipset $CHIP:Speed $SPEED Mhz:Cache $CACHE:PCPU $PCPU:CPU $CPU:Cores $CORES:HT $HT":$MEMORY
#echo "`hostname`:Chipset $CHIP:Vendor $VENDOR:PCPU $PCPU:CPU $CPU:Cores $CORES"
echo "Cores $CPU2" 
