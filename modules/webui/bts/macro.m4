divert(`-1') 

define(`_top_space', `<div id="topSpace">
</div>')dnl

# $1 is type of container
define(`_cont',`<div id="container" class="$1">
</div>')dnl

define(`_bot_space', `<div id="bottomSpace">
</div>')dnl

define(`_label',`<span id="$1">$2</span>')dnl

define(`_btn',`<button id="$1">$2</button>')dnl

# How many grid items should be included?
# Complex grid composition like advanced table macro
define(`_grid', `')dnl

define(`_screen_touch', `fullcreen touch input, which intercepts user input')dnl

# center popup
define(`_popup', `')dnl
# Can be positioned in anywhere this is floating menu
define(`_menu', `')dnl

# Everything should be a flex item
<div id="container" class="centerCont">
	<div id="header">bars
		Typically a nav buttons, also clickable 
	</div>
	<div id="content">
		Horizontal card list, vertical list items + Nested container
	</div>
	<div id="footer">
	</div>
</div>

divert`'dnl
