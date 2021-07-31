divert(`-1')

# Set varaible
define(`m_flowchart', `
`divert(`-1')'
`_set_var(v_flowchart_content, 
$*
include(cached)
)'
`divert`'dnl'
`divert(`-1')'
')dnl

# Directives macro
define(`_flowchart_begin', ``m_flowchart'`(' 
')dnl
define(`_flowchart_end', `
`)'')dnl

# Start
# _fstart(label,goto)
define(`_fstart',`start=>start: $1
esyscmd(`echo "start->$2" >> cached')dnl
')dnl

# End
# _fend(label)
define(`_fend',`end=>end: $1')dnl

# Flowchart node
# _fnode_cond(id,label,yesId,noId)
define(`_fcond',`$1=>condition: $2
esyscmd(`printf "$1(yes)->$3\n$1(no)->$4\n" >> cached')dnl
')dnl

# _fnode(id,label,nextId)
define(`_fnode',`$1=>operation: $2
esyscmd(`echo "$1->$3" >> cached')dnl
')dnl

# This was to make redirection look better,
# But I'm sure there would be a better approach.
# _fnode_right(id,label,nextId)
define(`_fnode_right',`$1=>operation: $2
esyscmd(`echo "$1(right)->$3" >> cached')dnl
')dnl

# _fnode_input(id,label,nextId)
define(`_finput',`$1=>inputoutput: $2
esyscmd(`echo "$1->$3" >> cached')dnl
')dnl

divert`'dnl
