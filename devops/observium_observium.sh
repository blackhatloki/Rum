#!/bin/bash
sudo ssh -L  80:localhost:80 teague@prince.hpc.nyu.edu -t sudo ssh -L 80:172.16.0.36:80 teague@prince-master0
