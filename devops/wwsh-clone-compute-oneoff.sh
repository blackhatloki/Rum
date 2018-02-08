#!/bin/bash
echo "wwsh -y  node clone c18-03 c18-04 "
echo "wwsh -y  node set c18-04 --netdev=eno1 --hwaddr=00:8c:fa:f7:04:6c"
echo "wwsh -y  node set c18-04 -D eno1 -I 172.16.0.142"
echo "wwsh -y  node set c18-04 -D ib0 -I 10.0.0.142"
echo "wwsh -y  object modify -s IPMI_IPADDR="192.168.0.142" c18-04"
echo "wwsh -y  node set $node -D ib7 -I  10.0.4.142 -M 255.255.252.0"
echo "wwsh -y  provision set $node --fileadd ifcfg-ib0_0 "
echo "wwsh -y  provision set $node --bootlocal=normal"
