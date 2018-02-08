#!/bin/bash
numberofem=` ip a s | egrep "em[0-9]?[0-9]:" | wc -l `
echo $numberofem
