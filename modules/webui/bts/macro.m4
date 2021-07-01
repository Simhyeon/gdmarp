divert(`-1') 
# =====
# Intenal macros
# Gets all contents into something other magic... I don't know
# ===> Start of m_webui macro
define(`m_webui', `
`divert(`-1')'
`_set_var(`m_webui_title', `$1')'
`_set_var(`m_webui_content', `shift($*)')'
`divert`'dnl'
')dnl
# <=== End of m_webui macro

# ===> Start of script macro
define(`m_script', `
`divert(`-1')'
`_set_var(`m_webui_script', `$*')'
`divert`'dnl'
')dnl
# <=== End of script macro

# =====
# Directives macro
# "$1," is necessary for the macro "m_webui" to operate
define(`_ui_begin', ``m_webui'`('$1, 
')dnl
define(`_ui_end', ``)'')dnl

# "$1," is necessary for the macro "m_webui" to operate
define(`_script_begin', ``m_script'`(' 
')dnl
define(`_script_end', ``)'')dnl

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

# DEBUG ::: ref, define(`_header', `<div class="gdHeader" style="flex-basis: $1">
# sub containers
define(`_header', `<div class="gdHeader $1">
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

define(`_footer', `<div class="gdFooter $1">
shift($*)
</div>')dnl # Has fixed size or ratio

# =====
# Horizontal macros
define(`_car', `')dnl # carousel

# =====
# General
define(`_img',`<div class="imgContainer"><img id="$1" class="img" style="width :$3 !important;" src="$2" alt="Img : $4"></img></div>')dnl
define(`_icon', `<i class="bi bi-$1"></i>')dnl
define(`_par', `<p>$*</p>')dnl
# _btn(id, classes, content)
define(`_btn', `<button id="$1" class="flexGrow btn $2">shift(shift($*))</button>')dnl
# _label(Text label content)
define(`_label',`<div id="$1" class="flexGrow gdLabel $2">
m_trim_nl(m_sanitize(shift(shift($*))))
</div>')dnl

# TODO 
define(`_grid',`')dnl

# ==========
# Selection
# Btn for selecting, area for selected div representation
# _sel_btn(target_id, Button text)
define(`_sel_btn',`<a class="btn" data-bs-toggle="collapse" href="#$1" role="button" aria-expanded="false" aria-controls="$1">
$2
</a>')dnl

# _sel_area(id) 
define(`_sel_area',`<div class="collapse" id="$1">
shift($*)
</div>')dnl

# Card component
define(`_card',`<div class="card card-body">
$*
</div>')dnl

# collection, simply collection of aligned div items
# collection doesnt expand but srhik while list view can be expanded with scroll bars
# _coll(orientation=["row" or "col"] ,loopCount, class, content)
define(`_coll_auto',`<div class="gdCollection $1Flex">
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

# ==========
# Scripts

# Add callback for event
# Origin id, eventType, callbackMacro 
define(`_add_call', `addCallback`('"$1", "$2",`('e`)' => {$3}`)'')dnl

# Add tooltip to element 
define(`_add_tooltip',`addProperties`('"$1"\.{"data-bs-toggle":"tooltip"\."data-bs-placement":"top"\."title":"$2"}`)'')dnl

# Call alert function
# e.g.) _add_call(alert, click, _call_alert(This is new text))
define(`_call_alert',`alert`('"$1"`)'')dnl

# Call element toggle function
define(`_call_toggle',`toggleElement`('"$1"`)'')dnl

# Call sync value function
define(`_call_sync', `')dnl

# Go to url
define(`_call_visit', `')dnl

# Call specific event on target
define(`_call_event', `')dnl

# Call update, or say set properties on target
define(`_call_update',`')dnl

divert`'dnl
