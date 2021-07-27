# First, remove first line's first row
# This strange regex is required because
# Given format is as followed
# ---
# test,1,2,3
# 4,5,6
# ---
# and we don't need "test" but the rest
# Second, change comma to pipe because comma is consumed by m4 macro
# to circumbent this change comma to pipe
# Third, change newline to comma
# This is to enable m4 macro to utilize csv format as if it were an array
printf '%s' "$*" | sed -e '1s/^[^,]*,//g' -e 's/,/|/g' | tr '\n' ','
