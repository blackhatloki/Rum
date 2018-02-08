#!/bin/bash 

tgt_host=wnl06a-7010b
rsync_opts="-av --rsh=ssh --progress " 
src_dir=/app/gobus_archive/tony
tgt_dir=/app/gobus2

for i in /app/gobus2 \
         /app/gobus2/Gms/data \
	 /app/gobus2/Gms/working ; 
do 
	echo "Directory $i" 
        echo "ssh $tgt_host "mkdir -p $tgt_dir""
        echo "rsync $rsync_opts $target_dir$i/ $tgt_host:$i" 
#       ssh $target "mkdir -p $target_dir$i"
#       rsync $rsync_opts $i $target:$target_dir$i
done 
