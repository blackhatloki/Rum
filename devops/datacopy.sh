#!/bin/bash 

target=nyl06a-7070 
rsync_opts="-av --rsh=ssh --progress " 
target_dir=/app/gobus_archive/tony

for i in /app/gobus2 \
         /app/gobus2/Gms/data \
	 /app/gobus2/Gms/working ; 
do 
	echo $i 
        echo "rsync $rsync_opts $i/* $target:$target_dir$i/" 
        ssh $target "mkdir -p $target_dir$i"
        rsync $rsync_opts $i $target:$target_dir$i
done 
