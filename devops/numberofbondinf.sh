#!/bin/bash
numberofbondedinterfaces=`ip a s | egrep "bond[0-9]?[0-9]:" | wc -l`
echo $numberofbondedinterfaces
