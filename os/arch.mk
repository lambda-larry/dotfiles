pkg-system-install:
	yay -S $(filter-out $(shell yay -Qq), $(PACKAGES))

pkg-system-purge:
	echo $(filter-out $(PACKAGES), $(shell yay -Qq --explicit)) | xargs -r yay -Rns --noconfirm

pkg-system-sync: pkg-system-install
	echo $(filter-out $(PACKAGES), $(shell yay -Qq --explicit)) | xargs -r yay -Rns --noconfirm

