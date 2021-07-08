divert(`-1')

// Directives
define(`_dial_begin',`{')dnl
define(`_dial_end',`}')dnl
// Speakers
define(`_speakers', `"speakers": [
	$*
]')dnl
// Speaker item
define(`_map',`{"id": "$1"\. "name": "$2"}')dnl
// Dialogue
define(`_dialogues',`"dialogues": [
	$*
]')dnl
// Dialogue item
define(`_flow',`{"id":"$1"\."redirect":"$2"\."content":[shift(shift($*))]}')dnl
// $4 is optional parameters
define(`_chunk', `{"type":"$1"\."speaker":"$2"\."text":"$3" shift(shift(shift($*)))}')dnl
// Dialogue selection properties
define(`_branch',`\."selection": [
		$*
]')dnl
define(`_sel',`{
	"text":"$1"\.
	"redirect":"$2"
}')dnl

divert`'dnl
