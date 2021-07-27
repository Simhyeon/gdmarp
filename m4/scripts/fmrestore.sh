# Restore pipe into comma, because macro needs to evaluate an array
printf '%s' "$*" | sed 's/|/,/g'
