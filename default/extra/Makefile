test:
	@gdmarp test
test-docker:
	@gdmarp test -d
prep:
	@gdmarp prep
repr:
	@gdmarp repr
repr-docker:
	@gdmarp repr -d
cnprep:
	@docker run --rm -v $(shell pwd):/home/marp/app --user="$(id -u):$(id -g)" simoncreek/gdmarp prep
cntest:
	@docker run --rm -v $(shell pwd):/home/marp/app --user="$(id -u):$(id -g)" simoncreek/gdmarp test
cnpptx:
	@docker run --rm -v $(shell pwd):/home/marp/app --user="$(id -u):$(id -g)" simoncreek/gdmarp repr
cnpdf:
	@docker run --rm -v $(shell pwd):/home/marp/app --user="$(id -u):$(id -g)" simoncreek/gdmarp repr -F pdf

.PHONY : test prep compile
