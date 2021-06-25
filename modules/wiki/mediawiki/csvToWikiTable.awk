BEGIN {
	FS=","
	lines = 0
	if (!caption) caption = "wikitable"
	print "{| class=""\042""wikitable""\042"
	print "|+ "caption # Caption should be given to file name
	print "|-"
}

{
	row = NF
	if(NR==1) {
		for (i=0; i<NF; i++) {
			headers[i] = $(i+1)
		}
	} else {
		for (i=0; i< NF ; i++) {
			field[( NF * lines ) + i] = $(i+1)
		}
		lines = lines + 1
	}
}

END {
	OFS= " !! "
	for (j in headers) {
		if (!printable) printable = headers[j]
		else printable = printable OFS headers[j]
	}
	printable = "! "printable
	print printable
	printable = ""
	print "|-"

	OFS= " || "
	for (f in field) {
		if (!printable) printable = "| "field[f]
		else {
			printable = printable OFS field[f]
		}
		
		if ( ( ( f + 1 ) % row ) == 0 ) {
			print printable
			printable = ""
			print "|-"
		}
	}
	print "|}"
}
