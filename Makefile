.PHONY: test release

VERSION := $(shell bin/clenv -v)
SHELLS  := sh bash zsh dash

test:
	shove -r t/bash -v -s /bin/bash
	set -e; \
	for sh in $(SHELLS); do shove t/*.t -v -s $$sh; done

release:
	git commit -m $(VERSION)
	git tag -a v$(VERSION) -m $(VERSION)
	git push origin v$(VERSION)
	git push origin master
