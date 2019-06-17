#!/bin/bash 
. ./ENV.sh
# [Key=BIOS.Setup.1-1#biosbootsettings]
# BootMode=Uefi
# BootMode=Bios
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set bios.biosbootsettings.BootMode Bios
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm jobqueue create BIOS.Setup.1-1 -r pwrcycle -s TIME_NOW -e TIME_NA
