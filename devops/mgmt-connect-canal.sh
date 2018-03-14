#!/bin/bash
sudo ssh -L 80:localhost:80  teague@dumbo0.es.its.nyu.edu -t sudo ssh -L 80:10.0.255.205:80  teague@10.0.255.205
