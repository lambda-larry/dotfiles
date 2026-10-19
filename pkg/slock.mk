include pkg/pkg.mk

deploy-pkg:   deploy-slock
clean-pkg:    clean-slock
undeploy-pkg: undeploy-slock


deploy-slock: VERSION := 1.7

deploy-slock: ${PREFIX}/lambda-larry/prefix/bin/slock
deploy-slock: ${PREFIX}/lambda-larry/prefix/share/man/man1/slock.1

undeploy-slock:
	$(RM) ${PREFIX}/lambda-larry/prefix/bin/slock
	$(RM) ${PREFIX}/lambda-larry/prefix/share/man/man1/slock.1

clean-slock:
	$(RM) pkg/slock/slock pkg/slock/*.o

pkg/slock/%.o: CC       := gcc
pkg/slock/%.o: CFLAGS   := -std=c99 -pedantic
pkg/slock/%.o: CFLAGS   += -Wall
pkg/slock/%.o: CFLAGS   += -O2
pkg/slock/%.o: CPPFLAGS += -MMD
pkg/slock/%.o: CPPFLAGS += -D_DEFAULT_SOURCE
pkg/slock/%.o: CPPFLAGS += -DVERSION='"$(VERSION)"'

pkg/slock/slock: LDFLAGS += $(shell pkg-config --libs x11 xext xrandr)
pkg/slock/slock: LDFLAGS += $(shell pkg-config --libs libcrypt)
pkg/slock/slock: LDFLAGS += $(shell pkg-config --libs pam)


-include $(wildcard pkg/slock/*.d)

${PREFIX}/lambda-larry/prefix/bin/%: pkg/slock/%
	install -Dm 0755 $< $@

${PREFIX}/lambda-larry/prefix/share/man/man1/%.1: pkg/slock/%.1
	install -Dm 0644 <(sed "s/VERSION/$(VERSION)/g" < $<) $@

