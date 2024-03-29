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

# Other wiki page link 
define(`_wiki_page',`[[$1]]')dnl
define(`_wiki_page_alt',`_wikipage($1|$2)')dnl # Wikipage link with alternative text

# Unordered List
define(`_ul', `ifelse(`$1', `', `*', `forloop(`', 1, $1, ``*'')')')dnl

# Ordered list
define(`_ol', `ifelse(`$1', `', `#', `forloop(`', 1, $1, ``#'')')')dnl

# Indentation
define(`_idt', `ifelse(`$1', `', `:', `forloop(`', 1, $1, `:')')')dnl

# URL Link (Same functionality wit markdown link)
define(`_url',`[$1 $2]')dnl

# Image Link
define(`_img',`[[File:$1|alt=$2]]')dnl

# Table (normal reading + raw csv)
# Read from csv file Second parameter is caption. Caption cannot include spaces use underscore instead
define(`_csv', `esyscmd(`awk -v caption=$2 -f $MODULE/wiki/mediawiki/csvToWikiTable.awk $1')')dnl

# Raw csv file
define(`_rcsv', `esyscmd(`echo "$*" | awk -f $SCRIPTS/rmExtNewLines.awk | awk -f $MODULE/wiki/mediawiki/csvToWikiTable.awk')')dnl

# Text with font size macro
# No font size if value 0, which is automatic in marp
define(`_text',`<div ifelse(`$1', `0', `', `style="font-size : $1px;"')>

m_trim_nl(m_sanitize(shift($*)))
</div>')dnl

divert`'dnl
