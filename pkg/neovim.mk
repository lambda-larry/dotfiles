
undeploy-nvim:
	$(RM) -r ${PREFIX}/lambda-larry/prefix-nvim

build-nvim:
	$(MAKE) -C pkg/neovim CMAKE_INSTALL_PREFIX=${PREFIX}/lambda-larry/prefix-nvim

deploy-nvim:
	$(MAKE) -C pkg/neovim install CMAKE_INSTALL_PREFIX=${PREFIX}/lambda-larry/prefix-nvim

clean-nvim:
	$(MAKE) -C pkg/neovim clean
