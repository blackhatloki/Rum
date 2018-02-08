#!/bin/bash
# gpu-24-10       gpu-29  90:2b:34:5f:eb:84 192.168.114.197  10.0.2.106 10.0.6.106 172.168.2.106
# gpu-24-15       gpu-24  90:2b:34:5f:d6:04 192.168.114.202  10.0.2.101 10.0.6.101 172.168.2.101
node=$1
mac=$2
ipipmi=$3
ibip=$4
ibip0=$5
ip=$6
echo "wwsh -y  node clone gpu-13 $node"
echo "wwsh -y  node set $node --netdev=eno1 --hwaddr=$mac"
echo "wwsh -y  node set $node -D eno1 -I $ip"
echo "wwsh -y  node set $node -D ib0 -I $ibip"
echo "wwsh -y  object modify -s IPMI_IPADDR="$ipipmi" $node"
echo "wwsh -y  node set $node -D ib7 -I $ibip0 -M 255.255.252.0"
echo "wwsh -y  provision set $node --fileadd ifcfg-ib0_0 "
echo "wwsh -y object modify -s diskformat=sda1,sda2,sdb1 $node"
echo "wwsh -y object modify -s filesystems="mountpoint=/boot:dev=sda1:type=ext4:size=512,dev=sda2:type=swap:size=2048,mountpoint=/:dev=sda3:type=ext4:size=fill,mountpoint=/state/partition1:dev=sdb1:type=ext4:size=fill" $node " 
echo "wwsh -y  provision set $node --bootlocal=normal"
