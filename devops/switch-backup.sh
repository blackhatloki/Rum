!/bin/bash
. ./ENV.sh

dns1=192.168.0.1
dns2=128.122.253.24
ntp1=192.168.0.1
ntp2=0.centos.pool.ntp.org
ntp3=1.centos.pool.ntp.org
snmp_dest=172.16.0.36
snmp_community=HPCNYU10ASTOR
smtp_server=192.168.0.1
mail_dest=hpc-notify@nyu.edu
timezone="US/Eastern"
syslog1=192.168.0.1
syslog2=172.16.0.36
syslog3=172.16.0.34
dnsdomainname=hpc.nyu.edu

echo 1
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set System.Location.DataCenter SDC
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.NIC.DNSDomainName   $dnsdomainname
