#!/bin/bash

SUDO=$(which sudo 2> /dev/null)

cd ${HOME}

echo -e "\e[35mDownloading environment configuration to $(pwd)...\e[0m"

if [ -d .dotfiles ]; then
	cd .dotfiles
	git pull
else
	git clone https://github.com/codisms/env-config.git .dotfiles
	cd .dotfiles
fi

echo -e "\e[35mDownloading submodules...\e[0m"
git submodule update --init --recursive

cd ..

function createSymlink() {
	local TARGET=$1
	local NAME=$2

	if [ -L ${NAME} ]; then
		rm ${NAME}
	fi
	if [ -f ${NAME} ]; then
		mv ${NAME} ${NAME}.disabled
	fi
	ln -s ${TARGET} ${NAME}
}

echo -e "\e[35mCreating symlinks...\e[0m"
createSymlink ./.dotfiles/repos/dircolors-solarized/dircolors.256dark .dircolors
createSymlink ./.dotfiles/zshrc .zshrc
createSymlink ./.dotfiles/gitconfig .gitconfig
createSymlink ./.dotfiles/elinks .elinks
createSymlink ./.dotfiles/muttrc .muttrc
createSymlink ./.dotfiles/ctags .ctags
createSymlink ./.dotfiles/eslintrc .eslintrc
createSymlink ./.dotfiles/editorconfig .editorconfig
createSymlink ./.dotfiles/psqlrc .psqlrc

echo "export PATH=\${PATH}:~/.dotfiles/bin" >> ~/.profile

echo -e "\e[35mSetting zsh as default shell...\e[0m"
[ -f /etc/ptmp ] && $SUDO rm -f /etc/ptmp
$SUDO chsh -s `which zsh` ${USER}

echo -e "\e[35mDownloading antigen modules...\e[0m"
zsh -c "source ~/.zshrc"

