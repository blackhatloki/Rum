#!/bin/bash 
dracip=$1
echo $dracip
sudo ssh -L 443:localhost:443 -L 5900:localhost:5900 -L 5901:localhost:5901 teague@gw.hpc.nyu.edu -t sudo ssh -L 443:localhost:443 -L 5900:localhost:5900 -L 5901:localhost:5901 teague@mercer0.es.its.nyu.edu  -t  sudo ssh  teague@soho -L 443:$dracip:443 -L 5900:$dracip:5900 -L 5901:$dracip:5901
