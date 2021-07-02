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
define(`_container',`<div id="container" class="gdContainer rowFlex">
$*
</div>')dnl

define(`_vcontainer',`<div id="container" class="gdContainer colFlex">
$*
</div>')dnl

# =====
# Layout macros

# sub containers
define(`_header', `<div id="header" class="gdHeader">
$*
</div>')dnl # Has fixed size or ratio

# _content(id, width, ...)
# _vcontent(id, height, ...)
define(`_content', `<div id="$1" class="gdContent rowFlex fullWidth m_default($2, flexGrow)" style="width: $2;">
shift(shift($*))
</div>')dnl

define(`_content_center', `<div id="$1" class="gdContent rowFlex flexCenter m_default($2, flexGrow)" style="width: $2;">
shift(shift($*))
</div>')dnl

define(`_vcontent', `<div id="$1" class="gdContent colFlex fullHeight m_default($2, flexGrow)" style="height: $2;">
shift(shift($*))
</div>')dnl

define(`_vcontent_center', `<div id="$1" class="gdContent colFlex flexCenter fullHeight m_default($2, flexGrow)" style="height: $2;">
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
define(`_img',`<img id="$1" class="img" style="width: $2; height: $2;" src="$3" alt="!!Image Not FOUND!!"></img>')dnl
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
define(`_coll',`<div id="$1" class="gdCollection rowFlex">
forloop(`i', 1, $2, `shift(shift($*))')
</div>')dnl 

define(`_vcoll',`<div id="$1" class="gdCollection colFlex">
forloop(`i', 1, $2, `shift(shift($*))')
</div>')dnl 

# Todo
# Simple list view
define(`_list_view',`<div class="gdListView">
</div>')dnl

# Modal macros
# Modal Header
define(`m_modal_header', `
<div class="modal-header">
	<h5 class="modal-title" id="exampleModalLabel">$1</h5>
	<button type="button" class="btn-close modal-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>')dnl
# Modal body
define(`m_modal_body', `
<div class="modal-body">
	$1
</div>')dnl
# Modal footer
define(`m_modal_footer', `
<div class="modal-footer">
	$1
</div>')dnl
# Modal user macros
define(`_modal',`
<div class="modal fade" id="$1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			m_modal_header($2)
			m_modal_body($3)
			m_modal_footer($4)
		</div>
	</div>
</div>
')dnl

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
# There were too much things to modify I just forced full html tags bc, why not
define(`_screen_touch', `
<div class="modal" id="$1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" onclick="``hideModal(this)''">
	<div class="modal-dialog modal-fullscreen">
		<div class="modal-content modal-tp text-white">
			<button type="button" style="display: none;" class="modal-close" data-bs-dismiss="modal" aria-label="Close"></button>
			<div class="modal-body" style="display: flex; justify-content: center; align-items: center;">
			$2
			</div>
			<div class="modal-footer" style="border: 0; justify-content: center;">
				Click to dismiss
			</div>
		</div>
	</div>
</div>
')dnl

# Sidebar
# Sidebar Left
define(`_sidebar_left', `
<div class="offcanvas offcanvas-start" tabindex="-1" id="$1" aria-labelledby="offcanvasWithBackdropLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="$1Label"></h5>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
	$2
  </div>
</div>
')dnl

# Sidebar Right
define(`_sidebar_right', `
<div class="offcanvas offcanvas-end" tabindex="-1" id="$1" aria-labelledby="offcanvasWithBackdropLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="$1Label"></h5>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
	$2
  </div>
</div>
')dnl

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

# Show Modal
define(`_call_modal',`callModal`('"$1"`)'')dnl

# Show Modal
define(`_hide_modal',`hideModal`('"$1"`)'')dnl

# Toggle sidebar
define(`_call_sidebar', `toggleSidebar`('"$1"`)'')dnl

divert`'dnl
