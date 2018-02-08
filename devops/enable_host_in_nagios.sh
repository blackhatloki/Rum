#!/bin/bash 
HOSTNAME=c39-06

declare -a arr=("Dell OMSA Amperage" "Dell OMSA Batteries" "Dell OMSA CPU" "Dell OMSA" "Esmhealth" "Dell OMSA FANS" "Dell OMSA Intrusion" "Dell OMSA Memory" "Dell OMSA POWER" "Dell OMSA Storage" "Dell OMSA TEMP" "Dell OMSA Voltage" "PING" "SSH" )
for SERVICE in "${arr[@]}"
do
# disable 
# curl -d "cmd_typ=23&cmd_mod=2&host=$HOSTNAME&service=$SERVICE&btnSubmit=Commit" "http://nagios/nagios/cgi-bin/cmd.cgi" -u "nagiosadmin:nagiosadmin"

# enable
curl -d "cmd_typ=22&cmd_mod=2&host=$HOSTNAME&service=$SERVICE&btnSubmit=Commit" "http://nagios/nagios/cgi-bin/cmd.cgi" -u "nagiosadmin:nagiosadmin"
done 
