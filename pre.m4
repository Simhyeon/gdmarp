divert(`-1') 
# ===
# Includes 
include(`foreach.m4')dnl
divert(`-1')

# ===
# Variables 
define(`v_img_height', `990')dnl
define(`v_font_default', `14')dnl

# ===
# Macros 
define(`m_width', `width:$1px')dnl
define(`m_height', `height:$1px')dnl
define(`m_class', `<!-- _class=$1 -->')dnl
define(`m_img', `
![$1]($2)')dnl
define(`m_img_auto', `eval( v_img_height / $1 )')dnl

# ===
# User interface macros 
define(`m_style', `<!-- $1 -->
<style>
include(`$1')</style>')dnl
define(`m_inc', `include(`$1')')dnl

# If first argument is 0 then calculate height devided by count of arguments and set it has height or just input given argument. (unit is pixel) 
define(`m_imgs',`foreach(`it', (`shift($*)'), `m_img(`m_height(`ifelse(`$1', `0', `m_img_auto( `eval( $# - 1 )')',`$1')')', it)')')dnl

# If first argument is 0 then set font size as default, or else input gien argument (unit is pixel) 
define(`m_text',`<div style="font-size : ifelse(`$1', `0', v_font_default, `$1')px;">
$2
</div>')dnl

define(`m_split', `m_class(split)')dnl
define(`m_left', `<div class="ldiv">')dnl
define(`m_right', `</div>
<div class="rdiv">')dnl
define(`m_end', `</div>')dnl
divert`'dnl
