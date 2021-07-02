#!/bin/sh

input=$(echo "$1" | xargs --)
default_value=$2

[ ${#input} -eq 0 ] && printf '%s' "$default_value" || printf '%s' "$input"
