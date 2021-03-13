divert(`-1') 
# ===
# Includes 
include(`foreach.m4')dnl
divert(`-1')

# ===
# Variables 
#
# Followed varaibles are declared in env.m4 file
# v_basis_height
# v_font_default
# v_thead_default

# ===
# Internal Macros 
define(`m_width', `width:$1px')dnl
define(`m_height', `height:$1px')dnl
define(`m_class', `<!-- _class: $1 -->')dnl # white space between _class: and $1 is necessary
define(`m_img', `
![$1]($2)')dnl
define(`m_img_auto', `eval( v_basis_height / $1 )')dnl
define(`m_trim_nl', `syscmd(`echo "$1" | awk -f m4_ext/rmExtNewLines.awk')')dnl

# Convert contents into single lined html
define(`m_scell', `syscmd(`echo "$1" | awk -f m4_ext/md2html.awk | awk -f m4_ext/merge_lines.awk -v d="" ')')dnl

# ===
# User interface macros 
define(`_styles', `<style>
foreach(`it', ($*), `<!-- it -->
include(it)
')</style>')dnl
define(`_inc', `include(`inc/$1.md')')dnl

# Awk csv file into md table and paste into it
define(`_csv', `syscmd(`awk -f m4_ext/csvToMd.awk $1')')dnl
define(`_rcsv', `syscmd(`echo "$*" | awk -f m4_ext/rmExtNewLines.awk | awk -f m4_ext/csvToMd.awk')')dnl

# Multiline support csv table related macros
define(`_ts', `<table>')dnl
define(`_tfont', `<style scoped>
	thead > tr > td { ifelse(`$1', `0', `font-size: v_thead_default()px !important;', `font-size: $1px !important;') }
	:not(thead) > tr > td { ifelse(`$2', `0', `font-size: v_thead_default()px !important;', `font-size: $2px !important;') }
</style>')
define(`_th', `<thead>
foreach(`it', ($*), `<td> m_scell(it) </td>')
</thead>')dnl
define(`_tr', `<tr>
foreach(`it', ($*), `<td> m_scell(it) </td>')
</tr>')dnl
define(`_te', `</table>')dnl

# If first argument is 0 then calculate height devided by count of arguments and set it has height or just input given argument. (unit is pixel) 
define(`_imgs', `foreach(`it', ($*), `m_img(`', it)')')dnl
define(`_simgs',`foreach(`it', (`shift($*)'), `m_img(`m_height(`ifelse(`$1', `0', `m_img_auto( `eval( $# - 1 )')',`$1')')', it)')')dnl

# If first argument is 0 then set font size as default, or else input gien argument (unit is pixel) 
# Div should be separated with new line to properly work
# m_trim_nl removes starting and trailing new lines
define(`_text',`<div style="font-size : ifelse(`$1', `0', v_font_default, `$1')px;">

m_trim_nl($2)
</div>')dnl

define(`_fbox', `<div style="flex:1;">

m_trim_nl($1)
</div>')dnl

define(`_ffbox', `<div style="flex:1; font-size: $1px;">

m_trim_nl($2)
</div>')dnl

define(`_title', `m_class(title)
`#' $1
`##' $2')dnl
define(`_tnc', `m_class(tnt)
`#' $1')dnl
define(`_cls', `m_class($1)')dnl
define(`_left', `<div class="ldiv">')dnl
define(`_right', `</div>
<div class="rdiv">')dnl
define(`_end', `</div>')dnl
divert`'dnl
