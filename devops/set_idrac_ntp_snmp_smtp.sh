#!/bin/bash
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
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.NICStatic.DNSDomainName $dnsdomainname
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.IPv4.DNS1 $dns1
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.IPv4.DNS2 $dns2
echo 2
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set idrac.IPMILan.AlertEnable Enabled
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set idrac.IPMILan.CommunityName $snmp_community
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set idrac.IPMILan.Enable Enabled
echo 3
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.SNMP.AgentEnable Enabled
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.SNMP.Alert.1 Enabled
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.SNMP.Alert.1.DestAddr $snmp_dest
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.SNMP.AgentCommunity $snmp_community
echo 4
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.SNMP.TrapFormat 1
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.Snmp.AgentEnable enabled
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.SNMP.AgentCommunity $snmp_community
echo 5
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set idrac.NTPConfigGroup.NTPEnable Enabled
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.Time.Timezone $timezone
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set idrac.NTPConfigGroup.ntp1 $ntp1
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set idrac.NTPConfigGroup.ntp2 $ntp2
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set idrac.NTPConfigGroup.ntp3 $ntp3
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.RemoteHosts.SMTPServerIPAddress $smtp_server
echo 6 
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.SysLog.Server1 $syslog1 
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.SysLog.Server2 $syslog2
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.SysLog.Server3 $syslog3
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.EmailAlert.Address.1 hpc-notify@nyu.edu
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.RemoteHosts.SMTPServerIPAddress $smtp_server
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.IPMILan.AlertEnable 1
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set idrac.SNMP.Alert.1.Enable 1
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm eventfilters set -c idrac.alert.all -a none -n email,snmp


# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm eventfilters set -c idrac.alert.storage.info -a none -n email,snmp
# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm eventfilters set -c idrac.alert.system.warning -a none -n email,snmp
# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm eventfilters set -c idrac.alert.storage.critical -a none -n email,snmp
# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm eventfilters set -c idrac.alert.system.critical -a none -n email,snmp
# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm eventfilters set -c idrac.alert.All.Critical -a none -n email,snmp
# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm eventfilters set -c idrac.alert.All.Warning  -a none -n email,snmp
# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm eventfilters set -c idrac.alert.system.info -a none -n email,snmp
# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm eventfilters set -c idrac.alert.system.warning -a none -n email,snmp

# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm testemail -i 1
# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm testsnmp  -i 1
# sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm testalert  -i 1
# racadm eventfilters help set

