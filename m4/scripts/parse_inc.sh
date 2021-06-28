#!/bin/sh

PATH=$1
CAND=inc/"$PATH".gdt

# If candiate file doesn't exist
if [ -f "$CAND" ]; then
	printf '..%s..' "$CAND"
else
	printf '..%s..' "$PATH"
fi
