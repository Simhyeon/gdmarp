test:
	@gdmarp test
test-docker:
	@gdmarp test --docker
prep:
	@gdmarp prep
compile:
	@gdmarp compile
compile-docker:
	@gdmarp compile --docker
cnprep:
	@docker run --rm -v $(shell pwd):/home/marp/app --user="$(id -u):$(id -g)" simoncreek/gdmarp prep
cntest:
	@docker run --rm -v $(shell pwd):/home/marp/app --user="$(id -u):$(id -g)" simoncreek/gdmarp test
cncompile:
	@docker run --rm -v $(shell pwd):/home/marp/app --user="$(id -u):$(id -g)" simoncreek/gdmarp compile
cnpdf:
	@docker run --rm -v $(shell pwd):/home/marp/app --user="$(id -u):$(id -g)" simoncreek/gdmarp compile --pdf

.PHONY : test prep compile
