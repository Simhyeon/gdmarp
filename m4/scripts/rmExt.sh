# This removes all whitespaces and newlines
# This alo removes duplicate whit spaces
printf '%s' "$*" | awk 'NF { $1=$1; print }' | perl -pe 'chomp if eof'
