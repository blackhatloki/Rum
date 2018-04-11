#!/bin/bash 
VM=$1
MAC=$MAC
virsh detach-interface --domain $VM --type bridge --mac $MAC --config  
