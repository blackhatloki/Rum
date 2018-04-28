#!/bin/bash 
timestamp=`date +%F`
OLD_IFS=$IFS
DSMSYS="/opt/tivoli/tsm/client/ba/bin/dsm.sys" 
TSMPWD="/etc/adsm/TSM.PWD" 
BACKUPDIR=/mnt/home/backup/ 

IFS=" 
"
### HOSTS="prince-master0.hpc.nyu.edu prince-master1.hpc.nyu.edu home-0.hpc.nyu.edu home-1.hpc.nyu.edu spring.es.its.nyu.edu babar.es.its.nyu.edu soho.es.its.nyu.edu greene.es.it.nyu.edu c14-04" 
HOSTS="prince-master0 prince-master1 home-0 home-1 spring.es.its.nyu.edu babar.es.its.nyu.edu soho.es.its.nyu.edu greene.es.its.nyu.edu c14-04" 
for i in $HOSTS ; do 
    echo "scp $i:$DSMSYS $BACKUPDIR`basename $DSMSYS.$i.$timestamp`"
    scp $i:$DSMSYS $BACKUPDIR`basename $DSMSYS.$i.$timestamp`
    echo "scp $i:$TSMPWD $BACKUPDIR`basename $TSMPWD.$i.$timestamp`"
    scp $i:$TSMPWD $BACKUPDIR`basename $TSMPWD.$i.$timestamp`
    echo
done 

IFS=$OLD_IFS
# find $BACKUPDIR -type f -name '*.gz' -mtime +7 -exec rm {} \;
exit 0
