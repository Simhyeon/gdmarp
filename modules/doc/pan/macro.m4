divert(`-1')dnl

# Pandoc uses markdown format as input
# Thus reuses marp macros

# Internals 
# Image
define(`m_img', `
![$1]($2)')dnl

# Basic syntax macros
# Headers
define(`_h1', `# $1')dnl
define(`_h2', `## $1')dnl
define(`_h3', `### $1')dnl
define(`_h4', `#### $1')dnl
define(`_h5', `##### $1')dnl

# Bold 
# define(`_b', `**$1**')dnl

# Italic 
# define(`_i', `*$1*')dnl

# ItalicBold 
# define(`_bi', `***$1***')dnl

# Strike through
define(`_st', `~~$1~~')dnl

# Underline
define(`_ud', `\_\_$1\_\_')dnl

# Indentation
# WARNING : Single spaces between if else bracket end and macro define bracket end
# is necessary, do not erase it.
define(`_idt', `ifelse(`$1', `', `', `forloop(`', 2, $1, `  ')') ')dnl

# Lists
# Unordered List
# Emtpry ul is same with level 1 
define(`_ul', `ifelse(`$1', `', `*', `forloop(`', 2, $1, `  ')*')')dnl

# Ordered list
define(`_ol', `ifelse(`$1', `', `1.', `forloop(`', 2, $1, `  ')1.')')dnl

# Paragraph
define(`_p',`<p>$*</p>')dnl

# MACRO >>> Awk script to convert csv file's content into github flavored formatted table 
# Usage :
# _csv(someCsvFile.csv)
define(`_csv', `esyscmd(`awk -f $MODULE/repr/marp/csvToMd.awk $1')')dnl

# MACRO >>> Extended version of csv macro which gets raw csv conent
# Usage :
# _rcsv(Name,Address,ID
# Simon,Seoul,1)
define(`_rcsv', `esyscmd(`echo "$*" | awk -f $SCRIPTS/rmExtNewLines.awk | awk -f $MODULE/repr/marp/csvToMd.awk')')dnl

# Image substitue macros
define(`_img', `m_img($2,$1)')dnl # $2 is alternate text, $1 is image url

# TODO 
# Add alignment macro
# Add font size macro

divert`'dnl
