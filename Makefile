-include local.mk

HOST := ${HOSTNAME}

-include hosts/${HOST}.mk
-include hosts/${USER}.mk
-include hosts/${HOST}-${USER}.mk

PREFIX ?= ${HOME}

deploy:

-include .index.d

.index.d: Makefile $(shell find files/ -type d)
	@echo -n > $@
	@find files/ -type f -printf 'deploy: $${PREFIX}/%P\n$${PREFIX}/%P: MODE := %#m\n' >> $@


${PREFIX}/%: files/%
	install -Dm ${MODE} $< $@

# Only install if the content is different (prevent flicker on make -B)
${PREFIX}/%/picom.conf: files/%/picom.conf
	cmp $< $@ || install -Dm ${MODE} $< $@

# We don't use symlink, just _duplicate_ code
${PREFIX}/.local/bin/git-init-%: MODE := 0755
${PREFIX}/.local/bin/git-init-%: files/.config/git/bin/git-init-template

deploy: ${PREFIX}/.local/bin/git-init-c
