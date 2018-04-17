#!/bin/bash 
grep "^menuentry" /boot/grub2/grub.cfg | cut -d "'" -f2
