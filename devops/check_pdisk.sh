#!/bin/bash 
omreport storage pdisk controller=0 | egrep "^ID|^Status|^Name|^State|^Power Status|^Failure Predicted" 
