#!/bin/bash 
#
# Program: Solaris RAID controller monitor <raidmon.sh>
#
# Author: Matty < matty91 at gmail dot com >
#
# Current Version: 1.0
#
# Revision History:
#
#  Version 1.0
#    Initial Release
#
# Last Updated: 04-01-2007
#
# Purpose:
#   This script checks the status of the LSI logic RAID controllers
#   that come with the Sun V40Z and X4200 line of servers.
#
# License:
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#

PATH=/bin:/usr/bin:/sbin:/usr/sbin
export PATH

ADMIN="ROOT"

RAID_STATUS=`raidctl -l | nawk '/^c[0-9]+t[0-9]+d[0-9]+/ && NF > 4 { if ( $3 ~ /OK/ ) { print "OK" } else { print "FAULT" } }'`

if [ "${RAID_STATUS}" = "FAULT" ]
then
     # Big brother should pick these up
     logger -p daemon.notice "ERROR: The RAID controller detected a fault"
     logger -p daemon.notice "ERROR: Run /usr/sbin/raidctl to check the RAID controller status"

     # Shoot an email to root to let someone know
     echo "" | mailx -s "RAID controller fault detected on $HOSTNAME" ${ADMIN}
     exit 1
fi

exit 0
