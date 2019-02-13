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
createSymlink ./.dotfiles/bashrc .bashrc
createSymlink ./.dotfiles/gitconfig .gitconfig
createSymlink ./.dotfiles/elinks .elinks
createSymlink ./.dotfiles/muttrc .muttrc
createSymlink ./.dotfiles/ctags .ctags
createSymlink ./.dotfiles/eslintrc .eslintrc
createSymlink ./.dotfiles/editorconfig .editorconfig
createSymlink ./.dotfiles/psqlrc .psqlrc

echo "export PATH=\${PATH}:~/.dotfiles/bin" >> ~/.profile

USE_BASH=0
for var in "$@"; do
	if [ "$var" == "--bash" ]; then
		USE_BASH=1
	fi
done

if [ $USE_BASH -eq 1 ]; then
	echo -e "\e[35mSetting bash as default shell...\e[0m"
	[ -f /etc/ptmp ] && $SUDO rm -f /etc/ptmp
	$SUDO chsh -s `which bash` ${USER}

	echo '
# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi
' >> ${HOME}/.bash_profile
else
	echo -e "\e[35mSetting zsh as default shell...\e[0m"
	[ -f /etc/ptmp ] && $SUDO rm -f /etc/ptmp
	$SUDO chsh -s `which zsh` ${USER}
fi

echo -e "\e[35mDownloading antigen modules...\e[0m"
zsh -c "source ~/.zshrc"

