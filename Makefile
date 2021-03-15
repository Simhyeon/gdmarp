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

.PHONY : test prep compile