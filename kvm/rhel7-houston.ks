#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use CDROM installation media
cdrom
# Use text mode install
text
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=vda
# Keyboard layouts
keyboard --vckeymap=us --xlayouts=''
# System language
lang en_US.UTF-8
# Installation logging level
logging --level=info
# Network information
network  --bootproto=static --device=eth0 --gateway=128.122.215.1 --ip=128.122.215.64 --netmask=255.255.255.0 --ipv6=auto --activate --hostname=houston
network  --bootproto=static --device=eth1 --ip=192.168.115.121 --netmask=255.255.252.0 --ipv6=auto --activate 
network  --bootproto=static --device=eth2 --ip=10.0.255.205 --netmask=255.255.252.0 --ipv6=auto --activate 
# Reboot after installation
reboot
# SELinux configuration
selinux --disabled
# Root password
rootpw --iscrypted $6$ZfLoRcK4dYBhoDVu$tTxJ8O9CS3HcIX/wJbF3vmlMwAR7gZHfPAvNAp9tQahkPmzQ255Oor2AxfVfuSAMZ4wr1KQpJpOzEoIMYIj9p1
# System services
services --enabled="chronyd"
# Do not configure the X Window System
skipx
# System timezone
timezone US/Eastern --isUtc

# System bootloader configuration
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=vda
autopart --type=lvm

# Partition clearing information
clearpart --all --initlabel --drives=vda

%packages
@core
chrony
kexec-tools

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=50 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=50 --notstrict --nochanges --notempty
pwpolicy luks --minlen=6 --minquality=50 --notstrict --nochanges --notempty
%end

%post  --log=/root/kickstarts-post.log

# redirect the output to the log file
exec >/root/kickstarts-post.log 2>&1
# show the output on the 7th console
tail -f /root/ks-post-anaconda.log >/dev/tty7 &
# changing to VT 7 that we can see what's going on....
/usr/bin/chvt 7

#
# Set the correct time
#
/usr/sbin/ntpdate -bus ip-time-1 ip-time-2
/sbin/clock --systohc

echo "search hpc.nyu.edu es.its.nyu.edu nyu.edu " >> /etc/resolv.conf
echo "nameserver 128.122.253.79 " >> /etc/resolv.conf
echo "nameserver 128.122.253.24 " >>  /etc/resolv.conf
 
yum -y install epel-release 
yum -y install ansible git
yum -y install screen
yum -y install sysstat
yum -y install wget 
yum -y install tcpdump
yum -y install sysstat
yum -y install strace
yum -y install logwatch

yum install aide -y && /usr/sbin/aide --init && cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz && /usr/sbin/aide --check
echo "05 4 * * * root /usr/sbin/aide --check" >> /etc/crontab

echo "NOZEROCONF=yes" >> /etc/sysconfig/network
echo "NETWORKING_IPV6=no" >> /etc/sysconfig/network
echo "IPV6INIT=no"  >>  /etc/sysconfig/network

echo "Idle users will be removed after 15 minutes"
echo "readonly TMOUT=900" >> /etc/profile.d/os-security.sh
echo "readonly HISTFILE" >> /etc/profile.d/os-security.sh
chmod +x /etc/profile.d/os-security.sh



# Update with new authorized_keys file
mkdir /root/.ssh
chmod 700 /root/.ssh
ssh-keygen -q -N ""  -t dsa  -f /root/.ssh/id_dsa
cat /root/.ssh/id_dsa.pub > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

cat <<EOF >>/etc/issue
## NOTICE: NYU HPC Authorized Use Only ##

Access and use, or causing access and use, of this computer system by anyone other than as permitted by New York University (NYU HPC) isstrictly prohibited by NYU and by law. Such use might subject an unauthorized user, including unauthorized employees, to criminal and civil penalties as well as NYU-initiated disciplinary proceedings. The use of this system is routinely monitored and recorded, and anyone accessing this system consents to such monitoring and recording.


EOF

cp /dev/null /etc/motd
cp /etc/issue /etc/issue.net 

echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf 
echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf 
echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog = 1280" >> /etc/sysctl.conf
echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf
echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_timestamps = 0" >> /etc/sysctl.conf
echo "kernel.exec-shield = 1" >> /etc/sysctl.conf

echo "Updating the system ..."
yum -y update
%end 
