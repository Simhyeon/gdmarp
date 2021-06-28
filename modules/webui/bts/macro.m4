divert(`-1') 
# =====
# Intenal macros
# Gets all contents into something other magic... I don't know
define(`m_webui', `
`divert(`-1')'
`_setvar(`m_webui_title', `$1')'
`_setvar(`m_webui_content', `shift($*)')'
`divert`'dnl'
')dnl

# =====
# Directives macro
# "$1," is necessary for the macro "m_webui" to operate
define(`_ui_begin', ``m_webui'`('$1, 
')dnl
define(`_ui_end', ``)'')dnl

# =====
# Top space macros
define(`_top_space', `<div id="topSpace" class="topSpace">
$*
</div>')dnl

define(`_top_left', `<div id="topLeft" class="topLeft">
$*
</div>')dnl

define(`_top_center', `<div id="topCenter" class="topCenter">
$*
</div>')dnl

define(`_top_right', `<div id="topRight" class="topRight">
$*
</div>')dnl

# =====
# Container macros
define(`_container',`<div class="gdContainer $1Flex">
shift($*)
</div>')dnl

# =====
# Layout macros

# sub containers
define(`_header', `<div class="gdHeader" style="flex-basis: $1">
shift($*)
</div>')dnl # Has fixed size or ratio

# _hcontent(alignment, ...)
# _vcontent(alignment, ...)
define(`_hcontent', `<div class="gdContent rowFlex $1" style="width: $2;">
shift(shift($*))
</div>')dnl

define(`_vcontent', `<div class="gdContent colFlex $1" style="height: $2;">
shift(shift($*))
</div>')dnl

define(`_footer', `<div class="gdFooter" style="flex-basis: $1">
shift($*)
</div>')dnl # Has fixed size or ratio

# =====
# Horizontal macros
define(`_carr', `')dnl # carrousel

# =====
# General
define(`_img',`<div class="imgContainer"><img class="img" style="width :$2 !important;" src="$1" alt="Img : $3"></img></div>')dnl
define(`_icon', `<i class="bi bi-$1"></i>')dnl
define(`_par', `<p>$*</p>')dnl
# _btn(type, classes, content)
define(`_btn', `<button class="flexGrow btn btn-$1 $2">shift(shift($*))</button>')dnl
# _label(Text label content)
define(`_label',`<div class="flexGrow gdLabel $1">
m_trim_nl(m_sanitize(shift($*)))
</div>')dnl

define(`_grid',`')dnl
# collection, simply collection of aligned div items
# collection doesn't expand but srhik while list view can be expanded with scroll bars
# _coll(orientation=["row" or "col"] ,loopCount, class, content)
define(`_collauto',`<div class="gdCollection $1Flex">
forloop(`i', 1, $2, `<div class="collItem $3">shift(shift(shift($*)))</div>')
</div>')dnl 
# Manual collection
define(`_coll',`<div class="gdCollection $1Flex">
shift($*)
</div>')dnl 
# Simple list view
define(`_list_view',`<div class="gdListView">
</div>')dnl

# =====
# Bottom space macros
define(`_bot_space', `<div id="botSpace" class="botSpace">
$*
</div>')dnl

define(`_bot_left', `<div id="botLeft" class="botLeft">
$*
</div>')dnl

define(`_bot_center', `<div id="botCenter" class="botCenter">
$*
</div>')dnl

define(`_bot_right', `<div id="botRight" class="botRight">
$*
</div>')dnl


# MISC
define(`_screen_touch', `fullcreen touch input, which intercepts user input')dnl

# center popup
define(`_popup', `')dnl
# Can be positioned in anywhere this is floating menu
define(`_menu', `')dnl

divert`'dnl
