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

# Substitue class name with marp compatible class form
define(`m_class', `<!-- \_class: $1 -->')dnl # white space between _class: and $1 is necessary
# Subsitue with markdown compatible image form
define(`m_img', `
![$1]($2)')dnl
# Make Set img's max-width with given arguments
define(`m_scaled_img',`<div style="text-align: inherit; flex: 1;"><img src="$1" style="width: 100%; max-width: $2; max-height: auto;"></img></div>
')dnl
# Convert contents into single lined html
# This was intended for multi line support in csv table
define(`m_scell', `esyscmd(`echo "$1" | awk -f $MODULE/repr/marp/md2html.awk | awk -f $MODULE/repr/marp/merge_lines.awk -v d="" | tr -d "\n" ')')dnl

# ==========
# User interface macros 

# Basic syntax macros
# Headers
define(`_h1', `# $1')dnl
define(`_h2', `## $1')dnl
define(`_h3', `### $1')dnl
define(`_h4', `#### $1')dnl
define(`_h5', `##### $1')dnl

# Bold 
# define(`_b', `**$1**')dnl

# Italic 
# define(`_i', `*$1*')dnl

# ItalicBold 
# define(`_bi', `***$1***')dnl

# Strike through
define(`_st', `~~$1~~')dnl

# Underline
define(`_ud', `\_\_$1\_\_')dnl

# Indentation
# WARNING : Single spaces between if else bracket end and macro define bracket end
# is necessary, do not erase it.
define(`_idt', `ifelse(`$1', `', `', `forloop(`', 2, $1, `  ')') ')dnl

# Lists
# Unordered List
# Emtpry ul is same with level 1 
define(`_ul', `ifelse(`$1', `', `*', `forloop(`', 2, $1, `  ')*')')dnl

# Ordered list
define(`_ol', `ifelse(`$1', `', `1.', `forloop(`', 2, $1, `  ')1.')')dnl

# Paragraph
define(`_p',`<p>$*</p>')dnl

# New page
define(`_new_page', `
---
')dnl

# MACRO >>> Get style files' name and paste the content
# Usage :
# _styles(image.css, layout.css)
define(`_styles', `<style>
foreach(`it', ($*), `/* it */
include(esyscmd(`printf $MODULE/repr/marp/')it)
')</style>')dnl

# MACRO >>> Awk script to convert csv file's content into github flavored formatted table 
# Usage :
# _csv(someCsvFile.csv)
define(`_csv', `esyscmd(`awk -f $MODULE/repr/marp/csvToMd.awk $1')')dnl

# MACRO >>> Extended version of csv macro which gets raw csv conent
# Usage :
# _rcsv(Name,Address,ID
# Simon,Seoul,1)
define(`_rcsv', `esyscmd(`echo "$*" | awk -f $SCRIPTS/rmExtNewLines.awk | awk -f $MODULE/repr/marp/csvToMd.awk')')dnl

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

# URL
define(`_url',`[$2]($1)')dnl # $2 is alternate text, $1 is image url

# Image substitue macros
define(`_img', `m_img($2,$1)')dnl # $2 is alternate text, $1 is image url
# MACRO >>> Simply substitue all image arguments with compatible form
define(`_imgs', `foreach(`it', ($*), `m_img(`', it)')')dnl
# MACRO >>> Convert all image arguments as of size with given value
define(`_simgs', `foreach( `it', (`shift($*)'), `m_scaled_img( it, `ifelse(`$1', `0', `m_bc_calc(`scale=2;(1 / ( $# - 1)) * 100')', `$1')')')')dnl
# Fixed position image
define(`_fimg',`<div style="position: fixed; top: $3; left: $4;" alt="$2">
<img style="width: $5;" src="$1"></img>
</div>')dnl
# MACRO >>> Compress image, only for jpeg and png 
# Example :
# _simgs(0.8, _comp(res/img.jpeg), _comp(res/emoji.png))
define(`_comp', `esyscmd(`bash $MODULE/repr/marp/compress.bash $1')')dnl

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

# Macro >>> set table of contents
define(`_toc',`<ol><a href="#$2">$1</a></ol>')dnl
# MACRO >>> Set title class into slide and type title, author text at the same time
define(`_title', `m_class(title)
`#' $1
`##' $2')dnl
# MACRO >>> Set any class of given arguments
define(`_cls', `m_class($1)')dnl

# Split screen related macros
# MACRO >>> Start left pane
define(`_left', `<div class="ldiv">
')dnl
# MACRO >>> Start right pane
define(`_right', `
</div>
<div class="rdiv">
')dnl
# MACRO >>> End split screen
define(`_end', `
</div>')dnl

# MACRO >>> Sql macro 
# Invoke sql query and get result as gfm formatted csv file 
# through sqlite in-memory csv virtual table.
define(`_sql_table', `_rcsv(_sql_query(ifelse(`$#', `3', `$@,v_bin_sqlite', `$*')))')dnl

# MACRO >>> Web api with csv auto formatting
# Not tested
define(`_wcsv', `_rcsv(esyscmd(`curl $1 | jq "$2"'))')dnl


# Center macro
define(`_center',`<div style="text-align:center; display:block; margin: 0 auto;">

$1</div>')dnl

divert`'dnl
