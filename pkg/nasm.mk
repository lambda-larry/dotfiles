deploy-pkg:   deploy-nasm
clean-pkg:    clean-nasm
undeploy-pkg: undeploy-nasm

deploy-nasm: ${PREFIX}/lambda-larry/prefix/bin/nasm
deploy-nasm: ${PREFIX}/lambda-larry/prefix/bin/ndisasm
deploy-nasm: ${PREFIX}/lambda-larry/prefix/share/man/man1/nasm.1
deploy-nasm: ${PREFIX}/lambda-larry/prefix/share/man/man1/ndisasm.1

undeploy-nasm:
	$(RM) ${PREFIX}/lambda-larry/prefix/bin/nasm
	$(RM) ${PREFIX}/lambda-larry/prefix/bin/ndisasm
	$(RM) ${PREFIX}/lambda-larry/prefix/share/man/man1/nasm.1
	$(RM) ${PREFIX}/lambda-larry/prefix/share/man/man1/ndisasm.1

clean-nasm:
	$(RM) pkg/nasm/nasm pkg/nasm/ndisasm pkg/nasm/*/*.o pkg/nasm/*.1 pkg/nasm/*.xml

pkg/nasm/%.o: CC       := gcc
pkg/nasm/%.o: CFLAGS   += -std=c23 -pedantic
pkg/nasm/%.o: CFLAGS   += -O2
pkg/nasm/%.o: CFLAGS   += -fwrapv
pkg/nasm/%.o: CFLAGS   += -ftrivial-auto-var-init=zero
pkg/nasm/%.o: CFLAGS   += -fno-common
pkg/nasm/%.o: CFLAGS   += -ffunction-sections
pkg/nasm/%.o: CFLAGS   += -fdata-sections
pkg/nasm/%.o: CFLAGS   += -fvisibility=hidden
pkg/nasm/%.o: CPPFLAGS += -MMD
pkg/nasm/%.o: CPPFLAGS += -imacros pkg/nasm/autoconf/attribute.h
pkg/nasm/%.o: CPPFLAGS += -imacros pkg/nasm/config/unconfig.h
pkg/nasm/%.o: CPPFLAGS += -DHAVE_CONFIG_H
pkg/nasm/%.o: CPPFLAGS += -D_GNU_SOURCE=1
pkg/nasm/%.o: CPPFLAGS += -Ipkg/nasm
pkg/nasm/%.o: CPPFLAGS += -Ipkg/nasm/include
pkg/nasm/%.o: CPPFLAGS += -Ipkg/nasm/x86
pkg/nasm/%.o: CPPFLAGS += -Ipkg/nasm/asm
pkg/nasm/%.o: CPPFLAGS += -Ipkg/nasm/output

pkg/nasm/%: LDFLAGS += -static
pkg/nasm/%: LDFLAGS += -Wl,--as-needed
pkg/nasm/%: LDFLAGS += -Wl,--gc-sections

-include $(wildcard pkg/nasm/*/*.d)

pkg/nasm/config/config.h:
	@echo -n '' > $@

pkg/nasm/nasm: $(patsubst %.c, %.o, $(wildcard pkg/nasm/asm/*.c))
pkg/nasm/nasm: $(patsubst %.c, %.o, $(wildcard pkg/nasm/common/*.c))
pkg/nasm/nasm: $(patsubst %.c, %.o, $(wildcard pkg/nasm/macros/*.c))
pkg/nasm/nasm: $(patsubst %.c, %.o, $(wildcard pkg/nasm/nasmlib/*.c))
pkg/nasm/nasm: $(patsubst %.c, %.o, $(wildcard pkg/nasm/output/*.c))
pkg/nasm/nasm: $(patsubst %.c, %.o, $(wildcard pkg/nasm/x86/*.c))
pkg/nasm/nasm: $(patsubst %.c, %.o, $(wildcard pkg/nasm/zlib/*.c))

pkg/nasm/ndisasm: $(patsubst %.c, %.o, $(wildcard pkg/nasm/common/*.c))
pkg/nasm/ndisasm: $(patsubst %.c, %.o, $(wildcard pkg/nasm/disasm/*.c))
pkg/nasm/ndisasm: $(patsubst %.c, %.o, $(wildcard pkg/nasm/nasmlib/*.c))
pkg/nasm/ndisasm: $(patsubst %.c, %.o, $(wildcard pkg/nasm/x86/*.c))

pkg/nasm/nasm:    ; $(CC) $(LDFLAGS) $^ -o $@
pkg/nasm/ndisasm: ; $(CC) $(LDFLAGS) $^ -o $@

${PREFIX}/lambda-larry/prefix/bin/%: pkg/nasm/%
	install -Dm 0755 $< $@

${PREFIX}/lambda-larry/prefix/share/man/man1/%.1: pkg/nasm/%.1
	install -Dm 0644 $< $@
