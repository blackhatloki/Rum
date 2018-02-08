#!/bin/bash
# compute-10-5    c99-05  44:a8:42:0a:97:2b 192.168.114.207  10.0.2.93  10.0.6.93 172.16.2.93
# * compute-10-6  c99-02  44:a8:42:10:11:41 192.168.114.208  10.0.2.92  10.0.6.92 172.16.2.92
# compute-10-7    c99-01  44:a8:42:10:b0:66 192.168.114.209  10.0.2.91  10.0.6.91 172.16.2.91
# gpu-24-10       gpu-29  90:2b:34:5f:eb:84 192.168.114.197  10.0.2.106 10.0.6.106 172.168.2.106
# gpu-24-15       gpu-24  90:2b:34:5f:d6:04 192.168.114.202  10.0.2.101 10.0.6.101 172.168.2.101
# phi-01-02 3c:fd:fe:25:52:c0  192.168.1.53 10.0.1.53 10.0.5.53 172.16.1.53
# phi-01-04 3c:fd:fe:25:50:40  192.168.1.54 10.0.1.54 10.0.5.53 172.16.1.54
node=$1
mac=$2
ipipmi=$3
ibip=$4
ibip0=$5
ip=$6
echo "wwsh -y  node clone c27-16 $node"
echo "wwsh -y  node set $node --netdev=eno1 --hwaddr=$mac"
echo "wwsh -y  node set $node -D eno1 -I $ip"
echo "wwsh -y  node set $node -D ib0 -I $ibip"
echo "wwsh -y  object modify -s IPMI_IPADDR="$ipipmi" $node"
echo "wwsh -y  node set $node -D ib7 -I $ibip0 -M 255.255.252.0"
echo "wwsh -y  provision set $node --fileadd ifcfg-ib0_0 "
echo "wwsh -y  provision set $node --bootlocal=normal"
