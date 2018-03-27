#!/bin/bash 
VM=$1
INTERFACE=$2
virsh attach-interface --domain $VM --type bridge --source $INTERFACE --model virtio --config --live 
