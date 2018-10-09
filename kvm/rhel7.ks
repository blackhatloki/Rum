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

# Network information
network  --bootproto=static --device=eth0 --gateway=128.122.215.1 --ip=128.122.215.68 --netmask=255.255.255.0 --ipv6=auto --activate
# network  --bootproto=static --device=eth0 --gateway=10.0.252.1 --ip=10.0.252.61 --netmask=255.255.252.0 --ipv6=auto --activate
network  --hostname=jarvis
#network  --hostname=bane

# Root password
rootpw --iscrypted $6$sQAPVbNl$wF6UHetQ0piAve3nzpyb59yrzL21Oy6JTAOR53466B/s1kagU49gYseHA/FYRc5q1Mb/YAm9h1KqpCvC2J8kj0
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
