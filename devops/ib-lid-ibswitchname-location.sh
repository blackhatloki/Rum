#!/bin/bash 
iblinkinfo | grep Switch | sed -e 's/Switch://' | sed -e 's/://g'
