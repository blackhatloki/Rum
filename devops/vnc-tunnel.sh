#!/bin/bash 
node=$1
port=$2
echo $node

sudo ssh -Y -L  $port:$node:$port  teague@prince1.hpc.nyu.edu 
