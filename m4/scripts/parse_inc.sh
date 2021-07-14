#!/bin/sh

PATH=$1
CAND=inc/"$PATH".gddt
CAND2=inc/"$PATH"

# If candiate file doesn't exist
if [ -f "$CAND" ]; then
	printf '%s' "$CAND"
elif [ -f "$CAND2" ]; then
	printf '%s' "$CAND2"
else
	printf '%s' "$PATH"
fi
