FILE=$1
BASE=${FILE%%.*}
EXT=${FILE##*.}
DIR=$(dirname "${FILE}")

# Basic workflow
# Get file as input
# Compress the file and send compressed file's name
# - Compression program : Optipng for png, jpegoptim for jpeg

if [[ "$EXT" = "jpg" ]] || [[ "$EXT" = "jpeg" ]]; then
	new_name="$BASE"_comp.jpg

	cp $FILE $new_name
	jpegoptim $new_name > /dev/null
	printf "$new_name"
elif [[ "$EXT" = "png" ]]; then
	new_name="$BASE"_comp.png

	cp $FILE $new_name
	optipng $new_name > /dev/null
	printf "$new_name"
else # Unsupported extesnio file is not processed
	echo $FILE
	exit 1;
fi
