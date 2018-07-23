#!/bin/bash 
nvidia-smi -q | egrep -i "^GPU|Serial Number|VBIOS Version|uuid|ECC"
