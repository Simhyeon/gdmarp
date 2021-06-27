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
define(`_container',`<div id="container" class="container">
$*
</div>')dnl

# =====
# Vertical layout macros
# However this can be used with nested horizontal macros

# sub containers
define(`_header', `')dnl # Has fixed size or ratio
define(`_content', `')dnl # Has fixed size or ratio
define(`_footer', `')dnl # Has fixed size or ratio
define(`_vsplit', `')dnl

# content formats
define(`_list_view',`')dnl

# =====
# Horizontal macros

# sub containers
define(`_hsplit', `')dnl

# content formats
define(`_carr', `')dnl # carrousel

# =====
# General
define(`_item', `')dnl
define(`_grid',`')dnl
define(`_coll',`')dnl # collection, simply collection of aligned div items

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

# =====
# Component macros
define(`_label',`<span>$1</span>')dnl

define(`_btn',`<button id="$1">$2</button>')dnl

define(`_icon', `<span><i>$1</i></span>')dnl

# MISC
define(`_screen_touch', `fullcreen touch input, which intercepts user input')dnl

# center popup
define(`_popup', `')dnl
# Can be positioned in anywhere this is floating menu
define(`_menu', `')dnl

divert`'dnl
