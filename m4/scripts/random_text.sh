#!/bin/sh
# Requires GNU sed

chars=$1
chars=$(( chars + 1 )) # Because logic contains first character as white space
count=0

# random_word $CharacterCount
random_word() {
	_word=$(base64 -w 0 /dev/urandom | head -c $1 | tr -c A-Za-z e | tr '[:upper:]' '[:lower:]')
	printf '%s' "$_word"
}

word_count=$(shuf -i 1-8 -n 1) # from 1 to 8 characters
while [ $count -lt $chars ]; do
	rword=$(random_word $word_count)
	result="$result $rword"
	count=$(( count + word_count ))

	word_count=$(shuf -i 1-8 -n 1) # from 1 to 8 characters
done


printf '%s' "$result" | head -c $chars | sed 's/^ *//g' 
