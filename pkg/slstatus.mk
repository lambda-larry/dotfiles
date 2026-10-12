include pkg/pkg.mk

deploy-pkg: deploy-slstatus
deploy-slstatus: ${PREFIX}/lambda-larry/prefix/bin/slstatus

${PREFIX}/lambda-larry/prefix/bin/slstatus: $(shell find pkg/slstatus -name '*.[ch1]' -or -name '*.mk')
	$(MAKE) PREFIX="${PREFIX}" -C pkg/slstatus install

