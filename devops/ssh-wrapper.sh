#!/bin/sh
 
USER=$(whoami)
LOG_FOLDER=/var/tmp/log/ssh/${USER}
# DATE=$(date +’%Y-%m-%d_%H:%M’)
DATE=$(date +%Y-%m-%d_%H:%M)
 
# case “$1″ in
#    ’hostA’)
#         HOST=”admin@hostA.example.com”
#         ;;
#    ’hostB’)
#        HOST=”admin@hostB.example.com”
#        ;;
#    *)
#        HOST=$1
#        ;;
#esac
 
LOG_FILE=${LOG_FOLDER}/${HOST}_${DATE}.log
 
[ ! -d ${LOG_FOLDER} ] && mkdir -p ${LOG_FOLDER}
 
# shift
echo $DATE $USER  $@
# logger  -p local6.debug "$(whoami) $@" 
# script -c “ssh ${HOST} $*” ${LOG_FILE}
