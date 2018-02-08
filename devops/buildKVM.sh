#!/bin/bash
virt-install  --network network:default  --name $1  --ram=512  --vcpus=1  --disk path=/home/vm-images/$1.img,size=20  --graphics none --location /home/iso/CentOS-6.9-x86_64-bin-DVD1.iso --extra-args="console=tty0 console=ttyS0,115200" --os-variant rhel7
