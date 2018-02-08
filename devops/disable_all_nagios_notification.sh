#!/bin/bash 
curl -d "cmd_mod=2&cmd_typ=11" "http://nagios/nagios/cgi-bin/cmd.cgi" -u "nagiosadmin:nagiosadmin"
