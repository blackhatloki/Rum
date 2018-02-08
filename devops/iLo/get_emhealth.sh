#!/bin/bash 
for i in `cat emhealth_host_list`  ; do 
    echo -n "$i  "
    ( ping -c 2 $i-ilo.equity.csfb.com  > /dev/null 2>&1) &&  ./locfg.pl -s $i-ilo.equity.csfb.com -f Get_EmHealth.xml
done 
