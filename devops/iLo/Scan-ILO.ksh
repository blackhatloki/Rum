#!/bin/ksh 
for i in `cat list` ; do 
    j=`echo $i | cut -f1 -d"."`
    k="$j"-ilo.ny.fw.gs.com 
    echo $k
    ./locfg.pl -s $k -l tmp_logs/$k -f Get_All_User_Info.xml
done 
