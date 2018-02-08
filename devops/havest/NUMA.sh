#!/bin/bash 
lscpu | grep -i -E  "CPU"  | grep NUMA
