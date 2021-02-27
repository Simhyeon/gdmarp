divert(`-1') 
# ===
# Includes 
include(`foreach.m4')dnl
divert(`-1')

# ===
# Variables 
define(`v_img_height', `500')dnl
define(`v_font_default', `22')dnl

# ===
# Internal Macros 
define(`m_width', `width:$1px')dnl
define(`m_height', `height:$1px')dnl
define(`m_class', `<!-- _class: $1 -->')dnl # white space between _class: and $1 is necessary
define(`m_img', `
![$1]($2)')dnl
define(`m_img_auto', `eval( v_img_height / $1 )')dnl

# ===
# User interface macros 
define(`_style', `<!-- $1 -->
<style>
include(`$1')</style>')dnl
define(`_inc', `include(`inc/$1.md')')dnl

# Awk csv file into md table and paste into it
define(`_csv', `syscmd(`awk -f m4_ext/csvToMd.awk $1')')

# If first argument is 0 then calculate height devided by count of arguments and set it has height or just input given argument. (unit is pixel) 
define(`_imgs',`foreach(`it', (`shift($*)'), `m_img(`m_height(`ifelse(`$1', `0', `m_img_auto( `eval( $# - 1 )')',`$1')')', it)')')dnl

# If first argument is 0 then set font size as default, or else input gien argument (unit is pixel) 
# Div should be separated with new line to properly work
# Syscmd removes starting and trailing new lines
define(`_text',`<div style="font-size : ifelse(`$1', `0', v_font_default, `$1')px;">

syscmd(`echo "$2" | awk -f m4_ext/rmNewLines.awk')
</div>')dnl

define(`_title', `m_class(title)')dnl
define(`_split', `m_class(split)')dnl
define(`_left', `<div class="ldiv">')dnl
define(`_right', `</div>
<div class="rdiv">')dnl
define(`_end', `</div>')dnl
divert`'dnl
