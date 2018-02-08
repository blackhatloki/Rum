#!/bin/bash 
OLD_IFS=IFS
IFS='
'
for i in `cat c01-c27-ib7` ; do 
node=`echo $i | awk -F" " ' { print $2 } ' `
ibip7=`echo $i | awk -F" " ' { print $1 } ' `
echo "wwsh -y provision set $node --bootstrap=3.10.0-514.10.2.el7.x86_64" 
echo "wwsh -y provision set $node --vnfs=centos7.3"
echo "wwsh -y node set $node -D ib7 -I $ibip7 -M 255.255.252.0"
echo "wwsh -y provision set $node --filedel ifcfg-ib7"
echo "wwsh -y provision set $node --fileadd ifcfg-ib0_0 "
echo "wwsh -y provision set $node --bootlocal=normal"
echo
done 
