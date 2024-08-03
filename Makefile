.PHONY: install
install: awesome gdb git python scripts terraform vim

.PHONY: awesome
awesome:
	mkdir -p ~/.config/awesome
	ln -sf $(shell pwd)/awesome/email.lua ~/.config/awesome/email.lua

.PHONY: gdb
gdb:
	mkdir -p ~/.cgdb
	ln -sf $(shell pwd)/gdb/cgdbrc ~/.cgdb/cgdbrc

.PHONY: git
git:
	ln -sf $(shell pwd)/git/gitconfig ~/.gitconfig
	ln -sf $(shell pwd)/git/gitignore ~/.gitignore

.PHONY: python
python:
	mkdir -p ~/.pip
	ln -sf $(shell pwd)/python/pip.conf ~/.pip/pip.conf

.PHONY: scripts
scripts:
	ln -sf $(shell pwd)/scripts/timing_http.sh ~/.local/bin/
	ln -sf $(shell pwd)/scripts/photo_classify.py ~/.local/bin/
	ln -sf $(shell pwd)/scripts/photo_rotate.py ~/.local/bin/

.PHONY: terraform
terraform:
	ln -sf $(shell pwd)/terraform/terraformrc ~/.terraformrc

.PHONY: vim
vim:
	ln -sf $(shell pwd)/vim/vimrc ~/.vimrc
	ln -sf $(shell pwd)/vim/genfiletags.sh ~/.local/bin/
