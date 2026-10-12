include pkg/pkg.mk

deploy-pkg:   deploy-dwm
clean-pkg:    clean-dwm
undeploy-pkg: undeploy-dwm


deploy-dwm: VERSION := 6.8

deploy-dwm: ${PREFIX}/lambda-larry/prefix/bin/dwm
deploy-dwm: ${PREFIX}/lambda-larry/prefix/share/man/man1/dwm.1

undeploy-dwm:
	$(RM) ${PREFIX}/lambda-larry/prefix/bin/dwm
	$(RM) ${PREFIX}/lambda-larry/prefix/share/man/man1/dwm.1

clean-dwm:
	$(RM) pkg/dwm/dwm pkg/dwm/*.o

pkg/dwm/%.o: CC       := gcc
pkg/dwm/%.o: CFLAGS   := -std=c99 -pedantic
pkg/dwm/%.o: CFLAGS   += -Wall
pkg/dwm/%.o: CFLAGS   += -O2
pkg/dwm/%.o: CPPFLAGS += -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L
pkg/dwm/%.o: CPPFLAGS += -DVERSION='"$(VERSION)"'
pkg/dwm/%.o: CPPFLAGS += -DXINERAMA
pkg/dwm/%.o: CPPFLAGS += $(shell pkg-config --cflags freetype2)

pkg/dwm/dwm: LDFLAGS += $(shell pkg-config --libs x11)
pkg/dwm/dwm: LDFLAGS += $(shell pkg-config --libs fontconfig)
pkg/dwm/dwm: LDFLAGS += $(shell pkg-config --libs xft)
pkg/dwm/dwm: LDFLAGS += $(shell pkg-config --libs xinerama)

pkg/dwm/%.o: pkg/dwm/config.h pkg/dwm/util.h
pkg/dwm/dwm: pkg/dwm/dwm.o pkg/dwm/drw.o pkg/dwm/util.o

${PREFIX}/lambda-larry/prefix/bin/%: pkg/dwm/%
	install -Dm 0755 $< $@

${PREFIX}/lambda-larry/prefix/share/man/man1/%.1: pkg/dwm/%.1
	install -Dm 0644 <(sed "s/VERSION/$(VERSION)/g" < $<) $@
