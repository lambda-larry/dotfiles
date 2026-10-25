HOST   ?= $(shell uname -n)
PREFIX ?= ${HOME}

-include local.mk

-include hosts/${HOST}.mk
-include hosts/${USER}.mk
-include hosts/${USER}@${HOST}.mk

deploy:

-include .index.d
-include .mode.d
-include .os-release.d

-include os/${OS_ID}.mk

.tab.d: Makefile $(shell find files/ -type d)
	find files/ -type f -fprintf $@  '$${PREFIX}/%P:%#m\n'

.index.d: .tab.d
	awk -F : '{ printf("deploy: %s\n", $$1) }' $< > $@

.mode.d: .tab.d
	awk -F : '{ printf("%s: MODE := %s\n", $$1, $$2) }' $< > $@

.os-release.d: /etc/os-release
	@tools/bash2make -v prefix=OS_ < $< > $@


${PREFIX}/%: files/%
	install -Dm ${MODE} $< $@

# Only install if the content is different (prevent flicker on make -B)
${PREFIX}/%/picom.conf: files/%/picom.conf
	cmp $< $@ || install -Dm ${MODE} $< $@

# We don't use symlink, just _duplicate_ code
${PREFIX}/.local/bin/git-init-%: MODE := 0755
${PREFIX}/.local/bin/git-init-%: files/.config/git/bin/git-init-template
	install -Dm ${MODE} $< $@

deploy: ${PREFIX}/.local/bin/git-init-c
