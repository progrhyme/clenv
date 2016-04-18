.PHONY: test release

VERSION := $(shell bin/clenv -v)

test:
	shove -r t -v -s /bin/bash

release:
	git commit -m $(VERSION)
	git tag -a v$(VERSION) -m $(VERSION)
	git push origin v$(VERSION)
	git push origin master
