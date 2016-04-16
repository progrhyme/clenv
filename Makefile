.PHONY: release

VERSION = $(shell bin/clenv -v)

release:
	git commit -m $(VERSION)
	git tag -a v$(VERSION) -m $(VERSION)
	git push origin v$(VERSION)
	git push origin master
