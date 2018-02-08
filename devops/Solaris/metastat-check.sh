#!/bin/sh
# -----------------------------------------------------------------------------
# Filename : metastat-check.sh
# Version  : 1.0
#
# Author   : Jens Schwarzer (JS)
# Date        : 07.12.2004
# Last Edit: 21.12.2005 by JS
#
# Purpose  : Checks with "metastat" for possible disk mirror error.
#                   Looks for the expression "Maintenance".
#                   The programm uses "logger" to send the output 
#                   via syslog directely to /var/adm/messages
#                   This script should be run via cron from root.
#          
# -----------------------------------------------------------------------------
#
#############################################
# Defining variables
#############################################

METACMD="`metastat|grep -i maint`"

TAG1="METASTAT-error"

#############################################
# Main Program
#############################################

# If the metastat command output are not empty 
# (when there is a string "Maintenance")
# Use "logger" to send the whole output  via syslog to /var/adm/messages.

if [ "$METACMD" != "" ]; then
 logger -p user.err -t $TAG1 $METACMD
fi

exit 0






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


