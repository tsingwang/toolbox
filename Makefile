.PHONY: install
install: vimrc git cgdbrc pip.conf

.PHONY: vimrc
vimrc:
	ln -sf $(shell pwd)/vim/vimrc ~/.vimrc
	ln -sf $(shell pwd)/vim/genfiletags.sh ~/.local/bin/

.PHONY: git
git:
	ln -sf $(shell pwd)/git/gitconfig ~/.gitconfig
	ln -sf $(shell pwd)/git/gitignore ~/.gitignore

.PHONY: cgdbrc
cgdbrc:
	mkdir -p ~/.cgdb
	ln -sf $(shell pwd)/cgdbrc ~/.cgdb/cgdbrc

.PHONY: pip.conf
pip.conf:
	mkdir -p ~/.pip
	ln -sf $(shell pwd)/pip.conf ~/.pip/pip.conf
