#!/bin/bash

PATH=$1
CAND=inc/"$PATH".md

# If candiate file doesn't exist
if [[ -f "$CAND" ]]; then
	printf $CAND
else
	printf $PATH
fi
