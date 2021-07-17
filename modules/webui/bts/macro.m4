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
# Content after ui_end is all discarded
define(`_ui_end', ``)'`divert(`-1')'')dnl

# "$1," is necessary for the macro "m_webui" to operate
define(`_script_begin', ``m_script'`(' 
')dnl
define(`_script_end', ``)'`divert(`-1')'')dnl

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
define(`_container',`<div id="container" class="gdContainer rowFlex hiddenFlow">
$*
</div>')dnl

define(`_vcontainer',`<div id="container" class="gdContainer colFlex hiddenFlow">
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
define(`_content', `<div id="$1" class="gdContent rowFlex fullSize hiddenFlow m_default($2, flexGrow)" style="width: $2;">
shift(shift($*))
</div>')dnl

define(`_content_center', `<div id="$1" class="gdContent rowFlex fullSize flexCenter hiddenFlow m_default($2, flexGrow)" style="width: $2;">
shift(shift($*))
</div>')dnl

define(`_vcontent', `<div id="$1" class="gdContent colFlex fullSize hiddenFlow m_default($2, flexGrow)" style="height: $2;">
shift(shift($*))
</div>')dnl

define(`_vcontent_center', `<div id="$1" class="gdContent colFlex flexCenter fullSize hiddenFlow m_default($2, flexGrow)" style="height: $2;">
shift(shift($*))
</div>')dnl

# Content scrollable
# This is technically listView
define(`_content_scroll',`
<div id="$1" class="fullSize" style="width: $2; overflow-x: scroll;">
shift(shift($*))
</div>')dnl
define(`_vcontent_scroll',`
<div id="$1" class="fullSize" style="height: $2; overflow-y: scroll;">
shift(shift($*))
</div>')dnl

define(`_footer', `<div id="footer" class="gdFooter">
$*
</div>')dnl # Has fixed size or ratio

# ==========
# Form macros
# Text input
define(`_tinput', `
<input id="$1" type="text" class="form-control" placeholder="$2" aria-label="Username" aria-describedby="basic-addon1">
')dnl
# Text input with labels
define(`_tinput_label', `
<div class="input-group mb-3">
  <span class="input-group-text" id="$1Label">$3</span>
  <input id="$1" type="text" class="form-control" placeholder="$2" aria-label="Username" aria-describedby="basic-addon1">
</div>
')dnl
# Number input
define(`_ninput', `
<input id="$1" type="number" class="form-control" placeholder="$2" aria-label="Username" aria-describedby="basic-addon1" onkeypress="return onlyNumberKey\9event\0">
')dnl
# Text input with labels
define(`_ninput_label', `
<div class="input-group mb-3">
  <span class="input-group-text" id="$1Label">$3</span>
  <input id="$1" type="number" class="form-control" placeholder="$2" aria-label="Username" aria-describedby="basic-addon1" onkeypress="return onlyNumberKey\9event\0">
</div>
')dnl

# Input Inline
define(`_inline',`<div class="inlineGroup">
$*
</div>')dnl

# Switch
define(`_switch',`
<div class="form-check form-switch">
	<input class="form-check-input" type="checkbox" id="$1">
	<label class="form-check-label" for="$1" id="$1Label">shift($*)</label>
</div>
')dnl

# Radio select
define(`_radio', `<div id="$1" class="radioGroup">
foreach(`it', (shift($*)), `m_radio($1, it)')
</div>')dnl
# Radio internal macro
define(`m_radio',`
<div class="form-check $3">
	<input class="form-check-input" type="radio" name="$1" id="$2" value="$2">
	<label class="form-check-label" for="$2" id="$2Label">$2</label>
</div>
')dnl

# Selection(Dropdown)
define(`_sel',`
<select id="$1" class="form-select" aria-label="Default select example">
	shift($*)
</select>
')dnl
# Selection items
define(`_sel_item',`
<option value="$1">$1</option>
')dnl

# Checkboxes
define(`_checkbox',`
<div class="form-check">
	<input class="form-check-input" type="checkbox" value="" id="$1">
	<label class="form-check-label" for="flexCheckDefault" id="$1Label">
		shift($*)
	</label>
</div>
')dnl

# Range
define(`_range',`
<label for="$1" class="form-label" id="$1Label">$2</label>
<input type="range" class="form-range" id="$1" min="$3" max="$4">
')dnl

# TODO carousel
define(`_car', `
<div id="$1" class="carousel slide" data-bs-ride="carousel">
	<div class="carousel-inner">
		shift($*)
	</div>
</div>')dnl
# carousel item
define(`_car_item',`
<div class="carousel-item">
	$*
</div>')
')dnl

# Dialogue
# _dial(id,speaker,text)
define(`_dial',`<div id="$1" class="dialogue">
	<div id="$1Speaker" class="dialogue-speaker">$2</div>
	<div id="$1Text" class="dialogue-text">$3</div>
</div>')dnl

# =====
# General
define(`_img',`<img id="$3" class="img" style="width: $4; height: $4;" src="$1" alt="Image not rendered : $2"></img>')dnl
# Icon
define(`_icon', `<i class="bi bi-$1"></i>')dnl
# Paragraph
define(`_p', `<p>$*</p>')dnl

# Button
# _btn(id, classes, content)
define(`_btn', `<button id="$1" class="flexGrow btn btn-primary">shift($*)</button>')dnl

# _label(Text label content)
define(`_label',`<div id="$1" class="">
shift($*)
</div>')dnl
# Label but center text
define(`_label_center',`<div id="$1" class="flexGrow gdLabel">
shift($*)
</div>')dnl

# MACRO >>> Squre grid macro
define(`_grid',`
<div class="gridContainer" id="$1" style="grid-template-columns: repeat\9auto-fill\. minmax\9 m_bc_calc(100 / $2)%\. 1fr\0\0;">
shift(shift($*))
</div>
')dnl
define(`_grid_cell', `
<div id="$1" class="grid"><div class="gridContent">
shift($*)
</div></div>')dnl

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

# Swappable items
# second argument or target parent should be same with parent div, element or _content's id
define(`_swap_item',`
<div id="$1" class="collapse" data-bs-parent="\3$2">
	shift(shift($*))
</div>
')dnl

# Card component
define(`_card',`<div id="$1" class="card card-body">
<h5 class="card-title">$2</h5>
shift(shift($*))
</div>')dnl
# Card with image
define(`_card_img',`<div id="$1" class="card card-body">
<img src="$3" class="card-img-top" alt="!!Card Image is not found!!">
<h5 class="card-title">$2</h5>
$4
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

# Modal macros
# Modal Header
define(`m_modal_header', `
<div class="modal-header">
	<h5 class="modal-title">$1</h5>
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
<div class="modal fade" id="$1" tabindex="-1" aria-hidden="true">
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
<div class="modal" id="$1" tabindex="-1" aria-hidden="true" onclick="``hideModal(this)''">
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
<div class="offcanvas offcanvas-start" tabindex="-1" id="$1">
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
<div class="offcanvas offcanvas-end" tabindex="-1" id="$1">
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
# Style modifier
# Css tyle and js script can use this modifier html tag to modify
# element that comes next to the modifier
define(`_style_next',`<modifier class="foreach(`it', ($*), ``mdf-'it() ')"></modifier>')dnl

# ==========
# Scripts

# Add callback for event
# Origin id, eventType, callbackMacro 
define(`_add_call', `addCallback`('"$1", "$2",`('ev`)' => {$3}`)'')dnl

# Add tooltip to element 
define(`_add_tooltip',`setProperties`('"$1"\.{"data-bs-toggle":"tooltip"\."data-bs-placement":"top"\."title":"$2"}`)'')dnl
define(`_add_tooltips', `
foreach(`it', ($*), `_add_tooltip(m_parse_pair(it))
')')dnl

# Call alert function
# e.g.) _add_call(alert, click, _call_alert(This is new text))
define(`_call_alert',`alert\9"$1"\0')dnl

# Call element toggle function
define(`_call_toggle',`toggleElement\9"$1"\0')dnl

# Call sync value function, while this says value but it syncs text
define(`_call_sync_text', `syncText\9"$1"\.ev\0')dnl

# Go to url
define(`_call_visit', `window.location="$1"')dnl

# Call specific event on target
define(`_call_event', `triggerEvent\9"$1" \. "$2"\0')dnl

# Call update, or say set properties on target
define(`_call_update',`setProperties\9"$1"\.{"$2" : "$3"}\0')dnl

# Show Modal
define(`_call_modal',`callModal\9"$1"\0')dnl

# Show Modal
define(`_hide_modal',`hideModal\9"$1"\0')dnl

# Toggle sidebar
define(`_call_sidebar', `toggleSidebar\9"$1"\0')dnl

divert`'dnl
