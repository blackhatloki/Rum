#!/bin/bash 
node=$1
mac=$2 
ip=$3 
ibip=$4 
ipipmi=$5
echo ""
echo "wwsh -y  node clone c27-16 $node"
echo "wwsh -y  node set $node --netdev=eno1 --hwaddr=$mac"
echo "wwsh -y  node set $node -D eno1 -I $ip"
echo "wwsh -y node set $node -D ib0 -I $ibip"
echo "wwsh -y  object modify -s IPMI_IPADDR="$ipipmi" $node"
echo "wwsh -y  object modify -s FILESYSTEMS=\"mountpoint=/boot:dev=sda1:type=ext4:size=2048,dev=sda2:type=swap:size=2048,mountpoint=/:dev=sda3:type=ext4:size=65536,mountpoint=/state/partition1:dev=sda4:type=ext4:size=fill\" $node"
echo "wwsh  -y  provision set $node --bootlocal=normal"
