#!/bin/sh

# This scripts gets two arguments
# First is a value to evaluate
# Second is the default value to print
# If first value is 0, then print default value
# if not, print given input value as it is

input=$(echo "$1" | xargs --)
default_value=$2

[ ${#input} -eq 0 ] && printf '%s' "$default_value" || printf '%s' "$input"
