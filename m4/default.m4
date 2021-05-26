divert(`-1') 
# ===
# Version 0.0.1
# ===
# Includes 
# Useful macro from official GNU source
include(`foreach.m4')dnl
divert(`-1')
include(`reverse.m4')dnl
divert(`-1')

# This should be in default m4, init? Not sure why it isn't
define(`argn', `ifelse(`$1', 1, ``$2'',
  `argn(decr(`$1'), shift(shift($@)))')')dnl

# ===
# Variables 
#
# Followed varaibles are declared in env.m4 file
# v_basis_height
# v_font_default
# v_thead_default

# ===
# Internal Macros 

# Substitue class name with marp compatible class form
define(`m_class', `<!-- _class: $1 -->')dnl # white space between _class: and $1 is necessary
# Subsitue with markdown compatible image form
define(`m_img', `
![$1]($2)')dnl
# Make Set img's max-width with given arguments
define(`m_scaled_img',`<div style="text-align: inherit; flex: 1;"><img src="$1" style="width: 100%; max-width: $2%; max-height: auto;"></img></div>
')dnl
# Send formula to program bc and return calculated result
define(`m_bc_calc', `esyscmd(`echo "$1" | bc | tr -d "\n" ')')dnl
# Trim all starting and trailing new lines from content
define(`m_trim_nl', `esyscmd(`echo "$*" | awk -f m4_ext/rmExtNewLines.awk')')dnl
# Sanitize content, or say temporarily convert content that disturbs sane macro operations
define(`m_sanitize', `esyscmd(`printf "$*" | sed -f m4_ext/sanitize.sed')')dnl

# Convert contents into single lined html
# This was intended for multi line support in csv table
define(`m_scell', `syscmd(`echo "$1" | awk -f m4_ext/md2html.awk | awk -f m4_ext/merge_lines.awk -v d="" | tr -d "\n" ')')dnl

# ==========
# User interface macros 

# MACRO >>> Get style files' name and paste the content
# Usage :
# _styles(css/image.css, css/layout.css)
define(`_styles', `<style>
foreach(`it', ($*), `<!-- it -->
include(it)
')</style>')dnl

# MACRO >>> Shorthand version of include macro
# macro expects path to be inside of "inc" directory
define(`_inc', `include(`inc/$1.md')')dnl

# MACRO >>> Awk script to convert csv file's content into github flavored formatted table 
# Usage :
# _csv(someCsvFile.csv)
define(`_csv', `syscmd(`awk -f m4_ext/csvToMd.awk $1')')dnl

# MACRO >>> Extended version of csv macro which gets raw csv conent
# Usage :
# _rcsv(Name,Address,ID
# Simon,Seoul,1)
define(`_rcsv', `syscmd(`echo "$*" | awk -f m4_ext/rmExtNewLines.awk | awk -f m4_ext/csvToMd.awk')')dnl

# Multiline support csv table related macros
# Refer macro.md for general usage
# Start table
define(`_ts', `<table>')dnl
# Set table font size
define(`_tfont', `<style scoped>
	thead > tr > td { ifelse(`$1', `0', `font-size: v_thead_default()px !important;', `font-size: $1px !important;') }
	:not(thead) > tr > td { ifelse(`$2', `0', `font-size: v_thead_default()px !important;', `font-size: $2px !important;') }
</style>')dnl
# Set table header
define(`_th', `<thead>
foreach(`it', ($*), `    <td>
        m_scell(it)
    </td>
')</thead>')dnl
# Set table row
define(`_tr', `<tr>
foreach(`it', ($*), `    <td>
        m_scell(it)
    </td>
')</tr>')dnl
# end table
define(`_te', `</table>')dnl

# Image substitue macros
# MACRO >>> Simply substitue all image arguments with compatible form
define(`_imgs', `foreach(`it', ($*), `m_img(`', it)')')dnl
# MACRO >>> Convert all image arguments as of size with given value
define(`_simgs', `foreach( `it', (`shift($*)'), `m_scaled_img( it, `m_bc_calc( ifelse( `$1', `0', `scale=2;(1 / ( $# - 1)) * 100', `scale=2; $1 * 100'))')')')dnl
# MACRO >>> Same with simgs macro but it's calculation is based on split screen
define(`_ssimgs', `foreach( `it', (`shift($*)'), `m_scaled_img( it, `m_bc_calc( ifelse( `$1', `0', `scale=2;(1 / ( $# - 1)) * 200', `scale=2; $1 * 100'))')')')dnl

# TODO >>> Compress only the first time, if compressed file already exists do not compress
# MACRO >>> Compress image, only for jpeg and png 
# Example :
# _simgs(0.8, _comp(res/img.jpeg), _comp(res/emoji.png))
define(`_comp', `esyscmd(`bash m4_ext/compress.bash $1')')dnl

# MACRO >>> Text macro that also sets font size for the text
#
# If first argument is 0 then set font size as default, or else input gien argument (unit is pixel) 
# ending div tag should be separated with new line to properly work
# m_trim_nl removes starting and trailing new lines
#
# Example :
# _text(26, yatti yatta)
define(`_text',`<div style="font-size : ifelse(`$1', `0', v_font_default, `$1')px;">

m_trim_nl(m_sanitize(shift($*)))
</div>')dnl

# MACRO >>> Flex box macro that makes div a flex display
# Intended for usage with split screen
define(`_fbox', `<div style="flex:1;">

m_trim_nl($*)
</div>')dnl

# MACRO >>> Flex box with given font size
define(`_ffbox', `<div style="flex:1; font-size: $1px;">

m_trim_nl(shift($*))
</div>')dnl

# Class related macros
# MACRO >>> Set title class into slide and type title, author text at the same time
define(`_title', `m_class(title)
`#' $1
`##' $2')dnl
# MACRO >>> Set "Title and Content" class for the slide
define(`_tnc', `m_class(tnt)
`#' $1')dnl
# MACRO >>> Set any class of given arguments
define(`_cls', `m_class($1)')dnl

# Split screen related macros
# MACRO >>> Start left pane
define(`_left', `<div class="ldiv">')dnl
# MACRO >>> Start right pane
define(`_right', `</div>
<div class="rdiv">')dnl
# MACRO >>> End split screen
define(`_end', `</div>')dnl

# MACRO >>> Comma macro
# Use _cc to substitute comma or else it will treat comma separated texts as arguments
define(`_cc', ``,'')dnl

# MACRO >>> Comment macro
# it justs removes all texts inside comment macro
define(`_comment', `')dnl

# MACRO >>> Sql macro 
# Invoke sql query and get result as gfm formatted csv file 
# through sqlite in-memory csv virtual table.
define(`_sql', `m_sqlbuilder(ifelse(`$#', `3', `$@,v_bin_sqlite', `$*'))')dnl

# Internal macro for deciding which sqlite to use 
# Change v_bin_sqlite varaible in env.m4 file to set path for sqlite
# or you can set your own custom sql program if it's command is compatible with sqlite
define(`m_sqlbuilder', `_rcsv(esyscmd(`printf ".mode csv\n.headers on\n.import $1 $2\n$3\n.exit" | $4'))')dnl

# MACRO >>> Web api macro
# Call curl function and parse it with jq specific command after then, print the result
define(`_wapi', `syscmd(`curl $1 | jq "$2"')')dnl

# MACRO >>> Web api with csv auto formatting
# Not tested
define(`_wcsv', `_rcsv(esyscmd(`curl $1 | jq "$2"'))')dnl

# Attribute based div wrapper macro
define(`_center',`<div style="text-align:center; display:block; margin: 0 auto;">

$1</div>')dnl

divert`'dnl
