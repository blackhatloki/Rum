#!/bin/bash 

target=joker 
rsync_opts="-av --rsh=ssh --progress " 
target_dir=/app/tmp

for i in /home/tteague4/  ; 
do 
	echo $i 
        echo "rsync $rsync_opts $i/* $target:$target_dir$i" 
#        ssh $target "mkdir -p $target_dir$i"
        rsync $rsync_opts $i $target:$target_dir$i
done 
