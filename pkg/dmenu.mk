include pkg/pkg.mk

deploy-pkg: deploy-dmenu
deploy-dmenu: ${PREFIX}/lambda-larry/prefix/bin/dmenu

${PREFIX}/lambda-larry/prefix/bin/dmenu: $(shell find pkg/dmenu -name '*.[ch1]' -or -name '*.mk')
	$(MAKE) PREFIX="${PREFIX}" -C pkg/dmenu install
