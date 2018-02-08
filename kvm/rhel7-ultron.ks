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
network  --bootproto=static --device=eth0 --gateway=128.122.215.1 --ip=128.122.215.67 --netmask=255.255.255.0 --ipv6=auto --activate
network  --hostname=ultron

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
