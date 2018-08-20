#!/bin/bash 
awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg
