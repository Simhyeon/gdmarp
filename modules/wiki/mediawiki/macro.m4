divert(`-1') 
# Purpose of wikitext macro is not about making all macros compliant with
# wikitext, rather it is about making markdown compatible wikitext macro

# Headers
define(`_h2', `==$1==')dnl
define(`_h3', `===$1===')dnl
define(`_h4', `====$1====')dnl
define(`_h5', `=====$1=====')dnl

# Bold triple quotes
# define(`_b', `''''$1'''')dnl

# Italic double quotes
# define(`_b', `'''$1''')dnl

# ItalicBold five quotes

# Strike through
define(`_st', `<s>$1</s>')dnl

# Underline
define(`_ud', `<u>$1</u>')dnl

# Internal Link

# Other wiki page link 

# Unordered List
# _ul(1)
# _ul(2)


# Ordered list
# _ol(1)
# _ol(2)

# Indentation

# URL Link (Same functionality wit markdown link)

# File Link

# Image Link

divert`'dnl
