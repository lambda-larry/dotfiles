-include local.mk

HOST := ${HOSTNAME}

-include hosts/${HOST}.mk
-include hosts/${USER}.mk
-include hosts/${HOST}-${USER}.mk

PREFIX ?= ${HOME}

deploy:

-include .index.d

.index.d: $(shell find files/ -type d)
	@echo -n > $@
	@find files/ -type f -printf 'deploy: $${PREFIX}/%P\n$${PREFIX}/%P: MODE := %#m\n' >> $@



${PREFIX}/%: files/%
	install -Dm ${MODE} $< $@

# Only install if the content is different (prevent flicker on make -B)
${PREFIX}/%/picom.conf: files/%/picom.conf
	cmp $< $@ || install -Dm ${MODE} $< $@
