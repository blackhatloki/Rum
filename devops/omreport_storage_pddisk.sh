#!/bin/bash 
omreport storage pdisk controller=0 | egrep "^ID|^Status|^State"
