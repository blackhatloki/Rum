#!/bin/bash
virt-install  --network network:default --network network:vsw03 --network network:vsw02 --name $1  --ram=512  --vcpus=4  --disk path=/home/vm-images/$1.img,size=80 --graphics none  --location /home/iso/CentOS-7-x86_64-DVD-1611.iso  --initrd-inject=/home/teague/rhel7-$1.ks --extra-args="ks=file:/rhel7-$1.ks console=tty0 console=ttyS0,115200"
# virt-install --name $1 --ram 2048 --vcpus=2 --disk pool=VMs,size=$2 --network bridge=ovsbr0 --network bridge=ovsbr1 --cdrom /home/kvm/CentOS-5.8-x86_64-bin-DVD-1of2.iso --noautoconsole --vnc --hvm --os-variant rhel5
