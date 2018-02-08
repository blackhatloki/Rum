#!/bin/sh
# name: checkdisk
#
# The checkdisk script checks predictive disk failure. It should be run daily.
#
# Read associated tech tip at:
#  http://www.sun.com/bigadmin/content/submitted/system_autocheck.jsp
#


MAIL_RECEIVER=tony.teague@gs.com
PATH=/usr/bin; export PATH

if iostat -En | egrep "Media Error: 1|Predictive Failure Analysis: 1" > /dev/null
then
    echo "Use iostat -En to diagnose\n" > /tmp/diskerror.txt
    iostat -En | egrep "Media Error: 1|Predictive Failure Analysis: 1" >> /tmp/diskerror.txt
    mailx -s "<hostname> Disk Error" $MAIL_RECEIVER < /tmp/diskerror.txt
fi


##############################################################################
### This script is submitted to BigAdmin by a user of the BigAdmin community.
### Sun Microsystems, Inc. is not responsible for the
### contents or the code enclosed. 
###
###
### Copyright 2008 Sun Microsystems, Inc. ALL RIGHTS RESERVED
### Use of this software is authorized pursuant to the
### terms of the license found at
### http://www.sun.com/bigadmin/common/berkeley_license.html
##############################################################################
