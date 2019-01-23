#!/bin/bash 
ipmitool sdr | egrep "PCIe Slot|Fan|PS Redundancy|Pwr Consumption" | sort
