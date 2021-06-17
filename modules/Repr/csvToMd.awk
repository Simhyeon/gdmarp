# https://stackoverflow.com/questions/49931215/table-creation-from-csv-file-with-headers-using-awk

BEGIN {
    FS=","
    OFS=" | "
    for (i=1; i<=NF; i++) {
        transientLength[i] = 0
    }
}

{
    if(NR==1) {
    # read headers
        for (i=0; i<NF; i++) {
            headers[i] = $(i+1)
            transientLength[i] = (length($(i+1))>=transientLength[i] ? length($(i+1)) : transientLength[i])
        }
    } else {
        for (i=0; i<NF; i++) {
            fields[NR][i] = $(i+1)
            transientLength[i] = (length($(i+1))>=transientLength[i] ? length($(i+1)) : transientLength[i])
        }
    }
}

END {
    # print header
    for (j in headers) {
        spaceLength = transientLength[j]-length(headers[j])
        for (s=1;s<=spaceLength;s++) {
            spaces = spaces" "
        }
        if (!printable) printable = headers[j] spaces
        else printable = printable OFS headers[j] spaces
        spaces = ""     # garbage collection
    }
    printable = "| "printable" |"
    print printable
    printable = ""      # garbage collection
    # print alignments
    for (j in transientLength) {
        for (i=1;i<=transientLength[j];i++) {
            sep = sep"-"
        }
        if (!printable) printable = sep
        else printable = printable OFS sep
        sep = ""        # garbage collection
    }
    printable = "| "printable" |"
    print printable
    printable = ""      # garbage collection
    # print all rows
    for (f in fields) {
        for (j in fields[f]) {
            spaceLength = transientLength[j]-length(fields[f][j])
            for (s=1;s<=spaceLength;s++) {
                spaces = spaces" "
            }
            if (!printable) printable = fields[f][j] spaces
            else printable = printable OFS fields[f][j] spaces
            spaces = ""     # garbage collection
        }
        printable = "| "printable" |"
        print printable
        printable = ""      # garbage collection
    }

}
