BEGIN {
	FS=","
	OFS=" "
}
{
	$1=$1
	print
}
