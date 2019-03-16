#!/bin/bash 
iptables -L 
iptables -F 
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -i ib0 -j ACCEPT
iptables -A OUTPUT -o ib0 -j ACCEPT
iptables -A INPUT -i ib1 -j ACCEPT
iptables -A OUTPUT -o ib1 -j ACCEPT
# Allow all incoming ssh 
iptables -A INPUT  -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
#  Allow Outgoing SSH
iptables -A OUTPUT  -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT   -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT 
# Allow outbound DNS
iptables -A OUTPUT -p udp  --dport 53 -j ACCEPT
iptables -A INPUT  -p udp  --sport 53 -j ACCEPT
# Allow Sendmail or Postfix Traffic 
iptables -A INPUT  -p tcp --dport 25 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 25 -m state --state ESTABLISHED -j ACCEPT
# Allow Ping from Outside to Inside
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j  DROP
#  Allow Ping from Inside to Outside
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
# rxmon  
iptables -A INPUT  -p tcp --dport 1311 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 1311 -m state --state ESTABLISHED -j ACCEPT
# gsiftp 
iptables -A INPUT  -p tcp --dport 2811 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 2811 -m state --state ESTABLISHED -j ACCEPT
# NFS 
iptables -A INPUT -s 128.122.214.110 -m state --state NEW -p udp --dport 111 -j ACCEPT
iptables -A INPUT -s 128.122.214.110 -m state --state NEW -p tcp --dport 111 -j ACCEPT
iptables -A INPUT -s 128.122.214.110 -m state --state NEW -p tcp --dport 2049 -j ACCEPT
iptables -A INPUT -s 128.122.214.110 -m state --state NEW -p tcp --dport 32803 -j ACCEPT
iptables -A INPUT -s 128.122.214.110 -m state --state NEW -p udp --dport 32769 -j ACCEPT
iptables -A INPUT -s 128.122.214.110 -m state --state NEW -p tcp --dport 892 -j ACCEPT
iptables -A INPUT -s 128.122.214.110 -m state --state NEW -p udp --dport 892 -j ACCEPT
iptables -A INPUT -s 128.122.214.110 -m state --state NEW -p tcp --dport 875 -j ACCEPT
iptables -A INPUT -s 128.122.214.110 -m state --state NEW -p udp --dport 875 -j ACCEPT
iptables -A INPUT -s 128.122.214.110 -m state --state NEW -p tcp --dport 662 -j ACCEPT
iptables -A INPUT -s 128.122.214.110 -m state --state NEW -p udp --dport 662 -j ACCEP
# Log Dropped Packets
iptables -N LOGGING
iptables -A INPUT -j LOGGING
iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "IPTables Packet Dropped: " --log-level 7
iptables -A LOGGING -j DROP
