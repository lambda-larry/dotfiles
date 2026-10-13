include pkg/pkg.mk

deploy-pkg:   deploy-slstatus
clean-pkg:    clean-slstatus
undeploy-pkg: undeploy-slstatus


deploy-slstatus: VERSION := 1.1

deploy-slstatus: ${PREFIX}/lambda-larry/prefix/bin/slstatus
deploy-slstatus: ${PREFIX}/lambda-larry/prefix/share/man/man1/slstatus.1

undeploy-slstatus:
	$(RM) ${PREFIX}/lambda-larry/prefix/bin/slstatus
	$(RM) ${PREFIX}/lambda-larry/prefix/share/man/man1/slstatus.1

clean-slstatus:
	$(RM) pkg/slstatus/slstatus pkg/slstatus/*.o pkg/slstatus/components/*.o

pkg/slstatus/%.o: CC       := gcc
pkg/slstatus/%.o: CFLAGS   := -std=c99 -pedantic
pkg/slstatus/%.o: CFLAGS   += -Wall
pkg/slstatus/%.o: CFLAGS   += -Wextra
pkg/slstatus/%.o: CFLAGS   += -Wno-unused-parameter
pkg/slstatus/%.o: CFLAGS   += -O2
pkg/slstatus/%.o: CPPFLAGS += -D_DEFAULT_SOURCE
pkg/slstatus/%.o: CPPFLAGS += -DVERSION='"$(VERSION)"'

pkg/slstatus/slstatus: LDFLAGS += $(shell pkg-config --libs x11)


pkg/slstatus/%.o: pkg/slstatus/slstatus.h
pkg/slstatus/slstatus.o: pkg/slstatus/arg.h pkg/slstatus/config.h pkg/slstatus/config.def.h pkg/slstatus/util.h

pkg/slstatus/slstatus: pkg/slstatus/slstatus.o pkg/slstatus/util.o $(patsubst %.c, %.o, $(wildcard pkg/slstatus/components/*.c))

${PREFIX}/lambda-larry/prefix/bin/%: pkg/slstatus/%
	install -Dm 0755 $< $@

${PREFIX}/lambda-larry/prefix/share/man/man1/%.1: pkg/slstatus/%.1
	install -Dm 0644 <(sed "s/VERSION/$(VERSION)/g" < $<) $@
