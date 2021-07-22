BEGIN {
	FS="/\\$|\\$/"
	OFS=""
}
{
	gsub(/,/,"\\.",$2)
	gsub(/'/,"\\;",$2)
	gsub(/`/,"\\~",$2)
	gsub(/\(/,"\\9",$2)
	gsub(/\)/,"\\0",$2)
	gsub(/_/,"_\\",$2)
	$1=$1
} 1