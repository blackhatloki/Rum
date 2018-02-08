#!/bin/bash 
virt-install  --network network:default  --name $1  --ram=512  --vcpus=1  --disk path=/home/vm-images/$1.img,size=80  --graphics none --location /home/iso/CentOS-6.9-x86_64-bin-DVD1.iso --initrd-inject=/home/teague/rhel6.ks --extra-args="ks=file:/rhel6.ks console=tty0 console=ttyS0,115200" --os-variant rhel6
