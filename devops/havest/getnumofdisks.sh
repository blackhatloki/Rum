#!/bin/bash 
fdisk -l | grep Disk | grep sd[a-z] | wc -l
