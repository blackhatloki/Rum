#!/bin/bash 
timestamp=`date +%F`
OLD_IFS=$IFS
BACKUPDIR=/mnt/home/backup_cron/ 

IFS=" 
"
HOSTS="log-0 log-1" 
for i in $HOSTS ; do 
    echo "ssh $i tar -cvf /var/tmp/$i.cron.$timestamp.tar /var/spool/cron "
    echo "ssh $i gzip -7 /var/tmp/$i.cron.$timestamp.tar "
    echo "scp $i:/var/tmp/$i.cron.$timestamp.tar.gz /mnt/home/backup_cron/" 

    ssh $i "tar -cvf /var/tmp/$i.cron.$timestamp.tar /var/spool/cron "
    ssh $i "gzip -7 /var/tmp/$i.cron.$timestamp.tar "
    scp $i:/var/tmp/$i.cron.$timestamp.tar.gz /mnt/home/backup_cron/
    echo
done 

IFS=$OLD_IFS
# find $BACKUPDIR -type f -name '*.gz' -mtime +7 -exec rm {} \;
exit 0
