dievert(`-1')dnl
// Directives
define(`_dial_begin',`{')dnl

define(`_dial_end',`{')dnl

// Speakers
define(`_speakers', `"Speakers": {
	$*
}')dnl
// Speaker item
define(`_sitem',`"id": "$1"\. "name": "$2"')dnl

// Dialogue
define(`_dialogues',`"dialogues": {
	$*
}')dnl

// Dialogue item
define(`_ditem',`"id":"$1"\."redirect":"$2"\."content":[shift(shift($*))]')dnl

// $4 is optional parameters
define(`_dcontent', `"type":"$1"\."speaker":"$2"\."text":"$3" $4')dnl

define(`_dselection',`\. "selection": [ $* ]')dnl

dievert(`')dnl
