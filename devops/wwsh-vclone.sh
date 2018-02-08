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
