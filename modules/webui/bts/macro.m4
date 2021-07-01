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
define(`_vcontainer',`<div id="container" class="gdContainer colFlex">
$*
</div>')dnl

define(`_hcontainer',`<div id="container" class="gdContainer rowFlex">
$*
</div>')dnl

# =====
# Layout macros

# sub containers
define(`_header', `<div id="header" class="gdHeader">
$*
</div>')dnl # Has fixed size or ratio

define(`_content', `<div id="$1" class="gdContent">
shift($*)
</div>')dnl

# _hcontent(id, width, ...)
# _vcontent(id, height, ...)
define(`_hcontent', `<div id="$1" class="gdContent rowFlex" style="width: $2;">
shift(shift($*))
</div>')dnl

define(`_vcontent', `<div id="$1" class="gdContent colFlex" style="height: $2;">
shift(shift($*))
</div>')dnl

define(`_footer', `<div id="footer" class="gdFooter">
$*
</div>')dnl # Has fixed size or ratio

# =====
# Horizontal macros
define(`_car', `')dnl # carousel

# =====
# General
# TODO Consider making image compat and make sized container macro
define(`_img',`<div class="imgContainer"><img id="$1" class="img" style="width :$3 !important;" src="$2" alt="Img : $4"></img></div>')dnl
# Icon
define(`_icon', `<i class="bi bi-$1"></i>')dnl
# Paragraph
define(`_par', `<p>$*</p>')dnl

# Button
# _btn(id, classes, content)
define(`_btn', `<button id="$1" class="flexGrow btn btn-primary">shift($*)</button>')dnl

# _label(Text label content)
define(`_label',`<div id="$1" class="flexGrow gdLabel">
shift($*)
</div>')dnl

# TODO 
define(`_grid',`')dnl

# ==========
# Swappable area
# Swapp button radio group
define(`_swap_buttons', `<div id="$1" class="btn-group" role="group">
foreach(`it', (shift($*)), `m_swap_button($1, it)')
</div>')dnl

# Single swap button
define(`m_swap_button',`
<input type="radio" class="btn-check" name="$1" value="no" id="$2"
       aria-expanded="false"
       aria-controls="$2"
       data-bs-toggle="collapse"
       data-bs-target="\3$2">
<label class="btn btn-outline-primary" for="$2">$2</label>
')dnl

define(`_swap_item',`
<div id="$1" class="collapse" data-bs-parent="\3$2">
	shift(shift($*))
</div>
')dnl

# Card component
define(`_card',`<div id="$1" class="card card-body">
shift($*)
</div>')dnl

# collection, simply collection of aligned div items
# collection doesnt expand but srhik while list view can be expanded with scroll bars
# _coll(id ,loopCount, content)
define(`_hcoll',`<div id="$1" class="gdCollection">
forloop(`i', 1, $2, `shift(shift($*))')
</div>')dnl 

define(`_vcoll',`<div id="$1" class="gdCollection">
forloop(`i', 1, $2, `shift(shift($*))')
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
define(`_add_call', `addCallback`('"$1", "$2",`('ev`)' => {$3}`)'')dnl

# Add tooltip to element 
define(`_add_tooltip',`setProperties`('"$1"\.{"data-bs-toggle":"tooltip"\."data-bs-placement":"top"\."title":"$2"}`)'')dnl

# Call alert function
# e.g.) _add_call(alert, click, _call_alert(This is new text))
define(`_call_alert',`alert`('"$1"`)'')dnl

# Call element toggle function
define(`_call_toggle',`toggleElement`('"$1"`)'')dnl

# Call sync value function
define(`_call_sync', `syncValue`('"$1"\.ev`)'')dnl

# Go to url
define(`_call_visit', `window.location="$1"')dnl

# Call specific event on target
define(`_call_event', `triggerEvent`('"$1" \. "$2"`)'')dnl

# Call update, or say set properties on target
define(`_call_update',`setProperties`("$1"\.{'"$2" : "$3"}`)'')dnl

divert`'dnl
