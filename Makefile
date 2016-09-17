.PHONY: test release shove

VERSION := $(shell bin/clenv -v)
SHELLS  := sh bash zsh dash
SHOVE   := vendor/shove/bin/shove

test: shove
	$(SHOVE) -r t/bash -v -s /bin/bash
	set -e; \
	for sh in $(SHELLS); do \
		if [ -x "$$(which $$sh)" ]; then \
			$(SHOVE) t/*.t -v -s $$sh; \
		else \
			echo "Skip $$sh"; \
			continue; \
		fi \
	done

shove:
	script/setup-shove.sh

release:
	git commit -m $(VERSION)
	git tag -a v$(VERSION) -m $(VERSION)
	git push origin v$(VERSION)
	git push origin master
