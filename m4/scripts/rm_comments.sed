# Remove all lines starting with double forward slashes but don't remove urls
# Exclamation negates given regex. In his case negate a case where double slash
# comes after colon(:) e.g. http:// or ftp:// are all ignored and preserverd
/[:]\/\//! s/\/\/.*//g
