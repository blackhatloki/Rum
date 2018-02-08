#!/bin/bash
virt-install  --network network:default  --name $1  --ram=512  --vcpus=1  --disk path=/home/vm-images/$1.img,size=60  --graphics none --location /home/iso/rhel-server-6.5-x86_64-dvd.iso --extra-args="console=tty0 console=ttyS0,115200" --os-variant rhel6
