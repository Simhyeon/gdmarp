BEGIN {
	FS="/\\$|\\$/"
	OFS=""
}
{
	gsub(/,/,"\\.",$2)
	gsub(/'/,"\\;",$2)
	gsub(/`/,"\\~",$2)
	$1=$1
} 1
