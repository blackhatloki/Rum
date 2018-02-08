#!/bin/bash
virt-install    --name $1  --ram=512  --vcpus=1  --disk path=/home/vm-images/$1.img,size=10  --graphics none  --nonetworks --location /home/iso/CentOS-6.9-x86_64-bin-DVD1.iso --extra-args="console=tty0 console=ttyS0,115200"
