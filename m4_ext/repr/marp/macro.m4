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

# ==========
# User interface macros 

# MACRO >>> Get style files' name and paste the content
# Usage :
# _styles(css/image.css, css/layout.css)
define(`_styles', `<style>
foreach(`it', ($*), `_comment(it)
include(it)
')</style>')dnl

# Image substitue macros
# MACRO >>> Simply substitue all image arguments with compatible form
define(`_imgs', `foreach(`it', ($*), `m_img(`', it)')')dnl
# MACRO >>> Convert all image arguments as of size with given value
define(`_simgs', `foreach( `it', (`shift($*)'), `m_scaled_img( it, `m_bc_calc( ifelse( `$1', `0', `scale=2;(1 / ( $# - 1)) * 100', `scale=2; $1 * 100'))')')')dnl
# Fixed position image
define(`_fimg',`<div style="position: fixed; top: $1; left: $2;">
<img style="width: $3;" src="$4"></img>
</div>')dnl
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

# Center macro
define(`_center',`<div style="text-align:center; display:block; margin: 0 auto;">

$1</div>')dnl

