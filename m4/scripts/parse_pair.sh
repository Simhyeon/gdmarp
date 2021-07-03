#!/bin/sh
# Given values looks like this key:value
pair=$*

echo "$pair" | awk -F":" -v OFS="," -v ORS="" '{print $1, $2}'
