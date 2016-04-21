.PHONY: test release

VERSION := $(shell bin/clenv -v)
SHELLS  := /bin/sh /usr/local/bin/bash /bin/bash /bin/zsh dash

test:
	shove -r t/bash -v -s /bin/bash
	set -e; \
	for sh in $(SHELLS); do shove t/clenv.t -v -s $$sh; done

release:
	git commit -m $(VERSION)
	git tag -a v$(VERSION) -m $(VERSION)
	git push origin v$(VERSION)
	git push origin master
