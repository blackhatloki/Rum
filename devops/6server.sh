#!/bin/bash
echo "wwsh -y  node clone c99-02 c99-01"
echo "wwsh -y  node set c99-01 --netdev=eno1 --hwaddr=44:a8:42:10:b0:66"
echo "wwsh -y  node set c99-01 -D eno1 -I 172.16.2.91"
echo "wwsh -y  node set c99-01 -D ib0 -I 10.0.2.91"
echo "wwsh -y  object modify -s IPMI_IPADDR="192.168.114.209" c99-01"
echo "wwsh -y  node set c99-01 -D ib7 -I 10.0.5.246 -M 255.255.252.0"
echo "wwsh -y  provision set c99-01 --fileadd ifcfg-ib0_0 "
echo "wwsh -y  provision set c99-01 --bootlocal=normal"
