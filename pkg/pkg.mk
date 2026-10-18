ifndef PKG_COMMON
PKG_COMMON := 1

${PREFIX}/lambda-larry/prefix/%: PREFIX := ${PREFIX}/lambda-larry/prefix

%.o: CPPFLAGS += -imacros autoconf/config.h

%.1: %.xml; xmlto man --skip-validation -o $(dir $@) $< 2>/dev/null
%.2: %.xml; xmlto man --skip-validation -o $(dir $@) $< 2>/dev/null
%.3: %.xml; xmlto man --skip-validation -o $(dir $@) $< 2>/dev/null
%.4: %.xml; xmlto man --skip-validation -o $(dir $@) $< 2>/dev/null
%.5: %.xml; xmlto man --skip-validation -o $(dir $@) $< 2>/dev/null
%.6: %.xml; xmlto man --skip-validation -o $(dir $@) $< 2>/dev/null
%.7: %.xml; xmlto man --skip-validation -o $(dir $@) $< 2>/dev/null

%.xml: %.txt
	asciidoc -b docbook -d manpage -o $@ $<
endif
