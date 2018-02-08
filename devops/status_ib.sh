#@/bin/bash 
 for i in `ls /sys/class/infiniband/*/ports/*/state`; do echo $i; cat $i; done
