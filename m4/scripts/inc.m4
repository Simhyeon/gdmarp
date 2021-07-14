divert(`-1')
# MACRO >>> Shorthand version of include macro
# macro expects path to be inside of "inc" directory
define(`_inc', `include(esyscmd(`sh $SCRIPTS/parse_inc.sh $1'))')dnl
divert`'dnl
