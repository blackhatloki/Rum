#!/bin/bash 
ip=$1
nm=$2
it=$3
gw=$4 
ip addr add $ip/$nm dev $it
ip link set $it up
ip route add $net/$nm via $gw dev $it
