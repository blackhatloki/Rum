#!/bin/bash 
mysqldump -u root -p --all-databases --databases > all-db-dump
