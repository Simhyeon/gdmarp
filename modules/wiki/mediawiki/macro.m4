divert(`-1') 
# Purpose of wikitext macro is not about making all macros compliant with
# wikitext, rather it is about making markdown compatible wikitext macro

# Headers
# H1 is actually page title and should be downgraded to h2
define(`_h1', `==$1==')dnl
define(`_h2', `==$1==')dnl
define(`_h3', `===$1===')dnl
define(`_h4', `====$1====')dnl
define(`_h5', `=====$1=====')dnl

# Bold triple quotes
define(`_b', `\;\;\;$1\;\;\;')dnl

# Italic double quotes
define(`_i', `\;\;$1\;\;')dnl

# ItalicBold five quotes
define(`_bi', `\;\;\;\;\;$1\;\;\;\;\;')dnl

# Strike through
define(`_st', `<s>$1</s>')dnl

# Underline
define(`_ud', `<u>$1</u>')dnl

# Comment
define(`_cm', `<!-- $1 -->')dnl

# Other wiki page link 
define(`_wikipage',`[[$1]]')dnl
define(`_wikipageAlt',`_wikipage($1|$2)')dnl # Wikipage link with alternative text

# Unordered List
define(`_ul', `forloop(`', 1, $1, ``*'')')dnl

# Ordered list
define(`_ol', `forloop(`', 1, $1, ``#'')')dnl

# Indentation
define(`_idt', `forloop(`', 1, $1, `:')')dnl

# URL Link (Same functionality wit markdown link)
define(`_url',`[$1 $2]')dnl

# Image Link
define(`_image',`[[File:$1|alt=$2]]')dnl

# Table (normal reading + raw csv)
# Read from csv file Second parameter is caption. Caption cannot include spaces use underscore instead
define(`_csv', `esyscmd(`awk -v caption=$2 -f $MODULE/wiki/mediawiki/csvToWikiTable.awk $1')')dnl

# Raw csv file
define(`_rcsv', `esyscmd(`echo "$*" | awk -f $SCRIPTS/rmExtNewLines.awk | awk -f $MODULE/wiki/mediawiki/csvToWikiTable.awk')')dnl

divert`'dnl
