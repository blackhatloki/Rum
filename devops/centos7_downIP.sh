#!/bin/bash 
ip=$1
nm=$2
it=$3
gw=$4 
ip route del $net/$nm via $gw dev $it
ip link set $it down
ip addr del $ip/$nm dev $it
