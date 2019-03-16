#!/bin/bash 
. ./ENV.sh
# https://www.dell.com/support/manuals/us/en/04/idrac7-8-lifecycle-controller-v2.40.40.40/idrac%20racadm%202.40.40.40/remoteimage?guid=guid-27bb405e-acbd-49f6-81b6-e400ab94ecc9&lang=en-us
# Connects, disconnects, or deploys a media file on a remote server.
# To run this subcommand, you must log in with virtual media privilege for iDRAC.
# racadm remoteimage [-m <module> | -a]
# racadm remoteimage -d [-m <module> | -a]
# racadm remoteimage -s [-m <module> | -a]
# racadm remoteimage -c [-m <module> | -a] [-u <username> -p <password> -l <image_path>]
# racadm remoteimage -e [-m <module> | -a] [-u <username> -p <password> -l <image_path>] 
# -c — Connect the image.  -d — Disconnect image.  -l — Image location on the network share; use single quotation marks around the location.
# -s — Display current status.
# NOTE: Use a forward slash (/) when providing the image location. If backward
# slash (\) is used, override the backward slash for the command to run successfully.
# For example:
# racadm remoteimage -c -u user -p xxx -l /\/\192.168.0.2/\CommonShare/\diskette
# NOTE: The following options only apply to connect and deploy actions -u — Username.
# User name to access the network share. For domain users, you can use the
# following formats: domain/user domain\user user@domain -p — Password to access the network share.
# Deploy a remote image on iDRAC CIFS Share.
# racadm remoteimage -c -u admin -p xxx -l //192.168.0/dev/floppy.img
# Deploy a remote image on iDRAC NFS Share.
# racadm remoteimage -c -u admin -p xxx -l '//192.168.0/dev/floppy.img'
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.VirtualMedia.BootOnce 1 
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm set iDRAC.ServerBoot.FirstBootDevice F11
sshpass -p $PASS ssh -n -o StrictHostKeyChecking=no -l $USER $1 racadm serveraction powercycle 
