#!/bin/bash
virt-install  --network network:default  --name $1  --ram=512  --vcpus=1  --disk path=/home/vm-images/$1.img,size=80 --graphics none  --location /home/iso/CentOS-7-x86_64-DVD-1611.iso  --initrd-inject=/home/teague/rhel7-ultron.ks --extra-args="ks=file:/rhel7-ultron.ks console=tty0 console=ttyS0,115200"
#virt-install  --network network:default  --name $1  --ram=512  --vcpus=1  --disk path=/home/vm-images/$1.img,size=80 --graphics none  --location /home/iso/CentOS-7-x86_64-DVD-1611.iso  --initrd-inject=/home/teague/rhel7n.ks --extra-args="console=tty0 console=ttyS0,115200"
