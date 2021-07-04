if($args[0] -eq "install-image"){
	docker pull simoncreek/gdmarp:latest
}else{
	docker run --rm -v ${PWD}:/home/marp/app simoncreek/gdmarp $args
}
