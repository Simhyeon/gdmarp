divert(`-1') 
# ===
# Version 0.0.1
# ===
# Includes 
# Useful macro from official GNU source
include(`foreach.m4')dnl
divert(`-1')
include(`forloop2.m4')dnl
divert(`-1')
include(`reverse.m4')dnl
divert(`-1')

# This should be in default m4, init? Not sure why it isn't
define(`argn', `ifelse(`$1', 1, ``$2'',
  `argn(decr(`$1'), shift(shift($@)))')')dnl

# ===
# Internal Macros 

# Send formula to program bc and return calculated result
define(`m_bc_calc', `esyscmd(`echo "$1" | bc | tr -d "\n" ')')dnl
# Trim all starting and trailing new lines from content
define(`m_trim_nl', `esyscmd(`echo "$*" | awk -f $SCRIPTS/rmExtNewLines.awk')')dnl
# Sanitize content, or say temporarily convert content that disturbs sane macro operations
define(`m_sanitize', `esyscmd(`printf "$*" | sed -f $SCRIPTS/sanitize.sed')')dnl
# Set to default value if given value is empty
define(`m_default', `esyscmd(`sh $SCRIPTS/default.sh $1 $2')')dnl
# Either enable or disable according to module used
define(`m_if_mod', `ifdef(`mod_$1',`shift($*)', `')')dnl

# ==========
# User interface macros 
#
# MACRO >>> If mod macros argument should be module name
define(`_if_mod', ``m_if_mod'`('$1,')dnl
define(`_elif_mod', ``)'`m_if_mod'`('$1,')dnl
define(`_fi_mod', ``)'')dnl

# MACRO >>> if mod macro but with single macro usage
define(`_if_modc',`m_if_mod($1, shift($*))')dnl

# ======''
# MACRO >>> Set variable as given name
# Usage : _set_var(`someurl', `http://google.com')
# Recommended naming rule is to start name with prefix "lv_" which stands for local variable
define(`_set_var', `define(`$1',
`ifelse(`$3', `0', ``$4'', `$2')')')dnl

# MACRO >>> Random texts macros for dev usage
# There are many spaces for improvements
define(`_rand_text',`esyscmd(`sh $SCRIPTS/random_text.sh $1')')dnl

# MACRO >>> Parse pair delmited by colon
# e.g. key:value
define(`m_parse_pair', `esyscmd(`sh $SCRIPTS/parse_pair.sh $1')')dnl

# MACRO >>> Repeat given arguments for given times
define(`_repeat',`forloop(`_i_', 1, $1, `shift($*)')')dnl

# MACRO >>> Shorthand version of include macro
# macro expects path to be inside of "inc" directory
define(`_inc', `include(esyscmd(`sh $SCRIPTS/parse_inc.sh $1'))')dnl

# MACRO >>> Comma macro
# Use _cc to substitute comma or else it will treat comma separated texts as arguments
define(`_cc', ``,'')dnl

# Internal macro for deciding which sqlite to use 
# Change v_bin_sqlite varaible in env.m4 file to set path for sqlite
# or you can set your own custom sql program if it's command is compatible with sqlite
define(`_sql_query', `esyscmd(`printf ".mode csv\n.headers on\n.import $1 $2\n$3\n.exit" | $4')')dnl

# MACRO >>> Web api macro
# Call curl function and parse it with jq specific command after then, print the result
define(`_wapi', `syscmd(`curl $1 | jq "$2"')')dnl

divert`'dnl
