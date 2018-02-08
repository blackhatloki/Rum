#!/bin/bash
numberofenp=` ip a s | egrep "enp[0-9][0-9][0-9]s0f[0-9]:" | wc -l `
echo $numberofenp
