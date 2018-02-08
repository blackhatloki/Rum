#!/bin/bash 
# After warewulf build the a system need to check of it booting of the OS disk 
# Teague 

PATH=/sbin:/bin:/usr/sbin:/usr/bin 
export PATH 

IFSOLD=$IFS 
kernel=`uname -r` 
cmdline=`cat /proc/cmdline  | awk -F" " ' { print $1 } ' | awk -F"=" ' { print $2 } ' | sed -e 's/\///'` 
vmkernel=vmlinuz-$kernel 

echo $cmdline $kernel $vmkernel
if [ "${cmdline}" !=  "${vmkernel}" ] ; then 
   echo "Booting off pxe" 
   # echo " Rebooting system to boot off OS disk"
   # echo " Make sure warewulf has boot off local disk enable" 
else 
   echo "Booting off OS disk" 
   # 
fi 
