#!/bin/bash 
# the same, only the output is base64 encoded for, e.g., e-mail
openssl enc -d -aes-256-cbc -in $1
