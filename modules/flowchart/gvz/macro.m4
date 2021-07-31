divert(`-1')

# Set varaible
define(`m_flowchart', `
`divert(`-1')'
`_set_var(v_flowchart_content, 
digraph G {
	$*
	include(cached)
}
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
define(`_fstart',`start [ label="$1" ];
esyscmd(`echo "start -> $2 [weight=8];" >> cached')dnl
')dnl

# End
# _fend(label)
define(`_fend',`end [label="$1"];')dnl

# _fnode(id,label,nextId)
define(`_fnode',`$1 [label="$2" shape=rect];
$1__RIGHT [width=0 shape=point];
{rank=same; $1; $1__RIGHT;}
esyscmd(`echo "$1 -> $3 [weight=8];" >> cached')dnl
')dnl

# Flowchart node
# _fnode_cond(id,label,yesId,noId)
define(`_fcond',`$1 [label="$2" shape=diamond];
$1__RIGHT [ width=0 shape=point ];
{rank=same; $1; $1__RIGHT;}
esyscmd(`printf "$1:e -> $1__RIGHT:w [arrowhead=none];\n$1 -> $3 [weight=8];\n$1__RIGHT:e -> $4__RIGHT:e [arrowhead=none];\n$4 -> $4__RIGHT [dir=back minlen=2];" >> cached')dnl
')dnl

# _fnode_input(id,label,nextId)
define(`_finput',`$1 [label="$2" shape=parallelogram];
$1__RIGHT [width=0 shape=point];
{rank=same; $1; $1__RIGHT;}
esyscmd(`echo "$1 -> $3 [weight=8];" >> cached')dnl
')dnl

divert`'dnl
