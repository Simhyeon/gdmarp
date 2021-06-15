#!/bin/sh

PATH=$1
CAND=inc/"$PATH".md

# If candiate file doesn't exist
if [ -f "$CAND" ]; then
	printf '..%s..' "$CAND"
else
	printf '..%s..' "$PATH"
fi
