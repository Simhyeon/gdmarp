divert(`-1')
# Comments are in default.m4
define(`_inc', `include(esyscmd(`sh $SCRIPTS/parse_inc.sh "$1"'))')dnl
divert`'dnl
