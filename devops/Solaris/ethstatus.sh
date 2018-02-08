#!/bin/bash
PATH=/sbin:/bin:/usr/bin:/usr/sbin
export PATH
for eth in `ip a s | grep UP |grep -v "NO-CARRIER"  | awk ' { print $2 } '|  egrep "eth|eqfn|bond0$|bond1$|tpnc|rmds|trade|mktout|corp|ord" | awk -F" " ' { print $1 } '  | sed -e 's/://g' `
  do
    echo -n "`hostname`",
    echo -n $eth,
    ethtool $eth  | egrep -i "Speed:|Duplex:|Link detected:" | sed -e 's/	*//g' | awk -F":" ' { printf "%s %s,",$1,$2 } ' 
    echo
    done
#     ifconfig $eth  | grep HWaddr | awk -F" " ' { printf "mac %s \n",$5 } ' | tr [A-Z] [a-z]
      if [ -e /proc/net/bonding/bond0 ] ; then 
      ethb=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond0 | tail -2 | egrep 'tpnc|eth|rmds|trade|corp' | awk -F":"  ' { print $2 } '  | sed -e 's/ //g'`  > /dev/null 2>&1
     macb=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond0 | tail -2 | egrep 'HW addr' | sed -e 's/Permanent HW addr: //g'`  > /dev/null 2>&1
     etha=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond0 | head -2 | egrep 'tpnc|eth|rmds|trade|corp' | awk -F":"  ' { print $2 } '  | sed -e 's/ //g'`  > /dev/null 2>&1
     maca=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond0 | head -2 | egrep 'HW addr'  | sed -e 's/Permanent HW addr: //g'`  > /dev/null 2>&1
     echo "$etha $maca"
     echo "$ethb $macb"
     fi 
     if [ -e /proc/net/bonding/bond1 ] ; then 
     ethc=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond1 | tail -2 | egrep 'tpnc|eth|rmds|trade|corp' | awk -F":"  ' { print $2 } '  | sed -e 's/ //g'`  > /dev/null 2>&1
     macc=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond1 | tail -2 | egrep 'HW addr' | sed -e 's/Permanent HW addr: //g'`  > /dev/null 2>&1
     ethd=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond1 | head -2 | egrep 'tpnc|eth|rmds|trade|corp' | awk -F":"  ' { print $2 } '  | sed -e 's/ //g'`  > /dev/null 2>&1
     macd=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond1 | head -2 | egrep 'HW addr'  | sed -e 's/Permanent HW addr: //g'`  > /dev/null 2>&1
     echo "$ethc $macc"
     echo "$ethd $macd"
     fi 
     if [ -e /proc/net/bonding/bond2 ] ; then 
     ethe=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond2 | tail -2 | egrep 'tpnc|eth|rmds|trade|corp' | awk -F":"  ' { print $2 } '  | sed -e 's/ //g'`  > /dev/null 2>&1
     mace=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond2 | tail -2 | egrep 'HW addr' | sed -e 's/Permanent HW addr: //g'`  > /dev/null 2>&1
     ethf=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond2 | head -2 | egrep 'tpnc|eth|rmds|trade|corp' | awk -F":"  ' { print $2 } '  | sed -e 's/ //g'`  > /dev/null 2>&1
     macf=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond2 | head -2 | egrep 'HW addr'  | sed -e 's/Permanent HW addr: //g'`  > /dev/null 2>&1
     echo "$ethe $mace"
     echo "$ethf $macf"
     fi 
     if [ -e /proc/net/bonding/bond3 ] ; then 
     ethg=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond3 | tail -2 | egrep 'tpnc|eth|rmds|trade|corp' | awk -F":"  ' { print $2 } '  | sed -e 's/ //g'`  > /dev/null 2>&1
     macg=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond3 | tail -2 | egrep 'HW addr' | sed -e 's/Permanent HW addr: //g'`  > /dev/null 2>&1
     ethh=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond3 | head -2 | egrep 'tpnc|eth|rmds|trade|corp' | awk -F":"  ' { print $2 } '  | sed -e 's/ //g'`  > /dev/null 2>&1
     mach=`egrep 'Slave Interface:|Permanent HW addr:'  /proc/net/bonding/bond3 | head -2 | egrep 'HW addr'  | sed -e 's/Permanent HW addr: //g'`  > /dev/null 2>&1
     echo "$ethg $macg"
     echo "$ethh $mach"
     fi 

     for j in ` ip a s | awk ' { print $2 } '|  egrep "eqfn|rmds|trade|mktout|eth-md|eth-ord" | awk -F" " ' { print $1 } '  | sed -e 's/://g' ` ; do 
     value=`ifconfig $j  | grep HWaddr | awk -F" " ' { printf "%s \n",$5 } ' | tr [A-Z] [a-z]`
     echo $j $value
     done
