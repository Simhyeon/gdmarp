divert(`-1')
# This technically doesn't set m4 quote.
# This script is useful when you're using macros that invoke macro defintion
# and you don't want to "expand"(which consumes all quote characters) the macro
# at the time.
changequote(`',`')dnl
divert`'dnl
