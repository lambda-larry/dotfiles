include pkg/pkg.mk

deploy-pkg:   deploy-dmenu
clean-pkg:    clean-dmenu
undeploy-pkg: undeploy-dmenu

deploy-dmenu: VERSION := 5.4

deploy-dmenu: ${PREFIX}/lambda-larry/prefix/bin/dmenu
deploy-dmenu: ${PREFIX}/lambda-larry/prefix/bin/dmenu_path
deploy-dmenu: ${PREFIX}/lambda-larry/prefix/bin/dmenu_run
deploy-dmenu: ${PREFIX}/lambda-larry/prefix/bin/stest

deploy-dmenu: ${PREFIX}/lambda-larry/prefix/share/man/man1/dmenu.1
deploy-dmenu: ${PREFIX}/lambda-larry/prefix/share/man/man1/stest.1

undeploy-dmenu:
	$(RM) ${PREFIX}/lambda-larry/prefix/bin/dmenu
	$(RM) ${PREFIX}/lambda-larry/prefix/bin/dmenu_path
	$(RM) ${PREFIX}/lambda-larry/prefix/bin/dmenu_run
	$(RM) ${PREFIX}/lambda-larry/prefix/bin/stest
	$(RM) ${PREFIX}/lambda-larry/prefix/share/man/man1/dmenu.1
	$(RM) ${PREFIX}/lambda-larry/prefix/share/man/man1/stest.1

clean-dmenu: $(wildcard pkg/dmenu/*.o)
	$(RM) $^ pkg/dmenu/dmenu pkg/dmenu/stest

pkg/dmenu/%.o: CC       := gcc
pkg/dmenu/%.o: CFLAGS   := -std=c99 -pedantic
pkg/dmenu/%.o: CFLAGS   += -Wall
pkg/dmenu/%.o: CFLAGS   += -O2
pkg/dmenu/%.o: CPPFLAGS += -MMD
pkg/dmenu/%.o: CPPFLAGS += -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L
pkg/dmenu/%.o: CPPFLAGS += -DVERSION='"5.4"'
pkg/dmenu/%.o: CPPFLAGS += -DXINERAMA
pkg/dmenu/%.o: CPPFLAGS += $(shell pkg-config --cflags freetype2)

pkg/dmenu/dmenu: LDFLAGS += $(shell pkg-config --libs x11)
pkg/dmenu/dmenu: LDFLAGS += $(shell pkg-config --libs fontconfig)
pkg/dmenu/dmenu: LDFLAGS += $(shell pkg-config --libs xft)
pkg/dmenu/dmenu: LDFLAGS += $(shell pkg-config --libs xinerama)


-include $(wildcard pkg/dmenu/*.d)
pkg/dmenu/dmenu: pkg/dmenu/dmenu.o pkg/dmenu/drw.o pkg/dmenu/util.o
pkg/dmenu/stest: pkg/dmenu/stest.o

${PREFIX}/lambda-larry/prefix/bin/%: pkg/dmenu/%
	install -Dm 0755 $< $@

${PREFIX}/lambda-larry/prefix/share/man/man1/%.1: pkg/dmenu/%.1
	install -Dm 0644 <(sed "s/VERSION/$(VERSION)/g" < $<) $@
