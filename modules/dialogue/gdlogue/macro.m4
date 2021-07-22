divert(`-1')

# Set varaible
define(`m_dialogue', `
`divert(`-1')'
`_set_var(`v_dial_content', `[
$*
]')'
`divert`'dnl'
')dnl

# Directives
# For ergnomics, end array with nullified object
# "$1," is necessary for the macro "m_webui" to operate
define(`_dial_begin', ``m_dialogue'`(' 
')dnl
define(`_dial_end', `{"id":null, "type": null, "goto": null}`)'`divert(`-1')'')dnl

# Dialogue nodes
define(`_dnode',`{
	shift(shift(shift($*)))
	"id":"$1",
	"type":"$2",
	"goto":"$3"
}\.')dnl

# Node attributes
# Text
define(`_dtext',`"text": "$1"\.')dnl
# Speaker
define(`_dspeaker',`"speaker": "$1"\.')dnl
# Diversion
# Emtpy goto is null, this just makes an array format compatible.
define(`_div',`"diversion": [
	$*
	{"goto": ""}
]\.')dnl
# Diversion select item
define(`_div_sel',`{
	"goto" : "$1",
	"text" : "$2"
}\.')dnl
# Diversion branch item
define(`_div_branch',`{
	"goto" : "$1",
	"target" : "$2",
	"qual": "$3"
}\.')dnl


divert`'dnl
