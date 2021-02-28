divert(`-1')
# Bang means comment
# divert means direction of stdout. 
# Contents between divert(`-1') and divert`' will not stdout
# 
# Basic Syntax 
# Macro name can start with characters or underscore
# Macro name and substituion should be delimited by comma or it doesn't work
# define(`_macro_name', `content to be substituted')
#
# Use dollar sign to reference given arguments
# define(`with_args', `$1 $2 $3')
# with_args(1,2,3) -> 1 2 3
# define(`all_args', `$*')
# with_args(1,2,3) -> 1,2,3 
# define(`arg_count', `$#')
# arg_count(1,2,3,4,5) -> 5
#
# Use shift built-in macro to shift an argument
# define(`shift_by_one' `shift($*)')
# shift_by_one(1,2,3) -> 2,3
#
# Use built-in macro syscmd to run bash command for macro substitution
# Surround syscmd's content with `' to send all commands intact to syscmd
# define(`_run_shell', `syscmd(`echo "Echo text from bash and paste stdout as macro substitution" ')')
#
# To escape reserved keywords or macros put `' arround it
# `macro_name' will not substitute but print literal 'macro_name' as text
# this is different from `' to differentiate macro name with macro substitution content
# define(`not_escaped', `this is not escpaed')
#
# New line characters are always preserved
# For example if this was a valid macro name, printed output would be multi lines
# define(`!invalid_name', `
# new line
# again new line with a single trailing new line
# ')
#
# You can remove all starting and trailing new lines with not so simple awk commands or use given m4_ext/rmExtNewLines.awk script
#
# Refer to official documentation for further information
# Link : https://www.gnu.org/software/m4/manual/
divert`'dnl
