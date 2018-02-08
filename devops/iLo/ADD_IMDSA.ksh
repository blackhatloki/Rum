#!/bin/ksh 
for i in `cat list` ; do 
    j=`echo $i | cut -f1 -d"."`
    k="$j"-ilo.ny.fw.gs.com 
    echo $k
    ./locfg.pl -s $k -l add_imdsa_logs/$k -f Add_User.xml
done 
