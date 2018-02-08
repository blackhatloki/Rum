#!/bin/bash 

OLD_IFS=$IFS
nodemin=1
nodemax=17 
chassis="28 29 30 31" 
 
for c in $chassis ; do 
    for  (( i=$nodemin; i<$nodemax; i++)) ;  do 
        hostname=""
        mac=""
        ip=""
        ibip=""
        ipipmi=""
        flag=0
        if [ $i -lt 10 ]
         then 
            grep c$c-0$i data5.dat > c$c-0$i.values.dat 
            if [ -s c$c-0$i.values.dat ] ; then
            echo "wwsh  -y node clone c27-16 c$c-0$i" 
            while IFS=',' read line ;do
            IFS=$OLD_IFS
            hostname=`echo $line | awk -F" " '{ print $1 } ' ` 
            mac=`echo $line |  tr A-Z a-z| awk -F" " ' { print $2 } ' `
            ip=`echo $line | awk -F" " ' { print $3 } ' ` 
            ibip=`echo $line | awk -F" " ' { print $4 } ' ` 
            ipipmi=`echo $line | awk -F" " ' { print $5 } ' ` 
            done < c$c-0$i.values.dat
            IFS=$OLD_IFS
            echo "wwsh  -y node set c$c-0$i --netdev=eno1 --hwaddr=$mac"
            echo "wwsh  -y node set c$c-0$i -D eno1 -I $ip"
#            echo "wwsh  -y node set c$c-0$i -D ib0 -I $ibip"
            echo "wwsh  -y object modify -s IPMI_IPADDR=\"$ipipmi\" c$c-0$i"
            echo "wwsh  -y  provision set c$c-0$i --bootlocal=normal"
            echo "./idrac-pxe.sh c$c-0$i-ipmi" 
#            echo "./idrac-powercycle.sh c$c-0$i-ipmi" 
            echo ""
            fi 
         else 
            grep c$c-$i data5.dat > c$c-$i.values.dat 
            if [ -s c$c-$i.values.dat ] ; then
            while IFS=',' read line  ; do
               IFS=$OLD_IFS
               hostname=`echo $line | awk -F" " ' { print $1 } ' ` 
               mac=`echo $line |  tr A-Z a-z | awk -F" " ' { print $2 } ' `
               ip=`echo $line | awk -F" " ' { print $3 } ' ` 
               ibip=`echo $line | awk -F" " '  { print $4 } ' ` 
               ipipmi=`echo $line | awk -F" " '  { print $5 } ' ` 
            done < c$c-$i.values.dat
            IFS=$OLD_IFS
            echo "wwsh  -y node clone c27-16 c$c-$i" 
            echo "wwsh  -y node set c$c-$i --netdev=eno1 --hwaddr=$mac"
            echo "wwsh  -y node set c$c-$i -D eno1 -I $ip"
#            echo "wwsh  -y node set c$c-$i -D ib0 -I $ibip" 
            echo "wwsh  -y object modify -s IPMI_IPADDR=\"$ipipmi\" c$c-$i"
            echo "wwsh  -y provision set c$c-$i --bootlocal=normal"
            echo "./idrac-pxe.sh c$c-$i-ipmi" 
#            echo "./idrac-powercycle.sh c$c-$i-ipmi" 
            echo ""
         fi 
         fi 
    done 
done 
