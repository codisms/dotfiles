#!/bin/bash

SUDO=$(which sudo 2> /dev/null)

cd ${HOME}

echo -e "\e[35mDownloading vim configuration to $(pwd)...\e[0m"

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

echo -e "\e[35mCreating symlinks...\e[0m"
[ ! -f .dircolors ] && ln -s ./.dotfiles/repos/dircolors-solarized/dircolors.256dark .dircolors
[ ! -f .zshrc ] && ln -s ./.dotfiles/zshrc .zshrc
[ ! -f .gitconfig ] && ln -s ./.dotfiles/gitconfig .gitconfig
[ ! -f .elinks ] && ln -s ./.dotfiles/elinks .elinks
[ ! -f .muttrc ] && ln -s ./.dotfiles/muttrc .muttrc
[ ! -f .ctags ] && ln -s ./.dotfiles/ctags .ctags
[ ! -f .eslintrc ] && ln -s ./.dotfiles/eslintrc .eslintrc
[ ! -f .editorconfig ] && ln -s ./.dotfiles/editorconfig .editorconfig
[ ! -f .psqlrc ] && ln -s ./.dotfiles/psqlrc .psqlrc

echo -e "\e[35mSetting zsh as default shell...\e[0m"
[ -f /etc/ptmp ] && $SUDO rm -f /etc/ptmp
$SUDO chsh -s `which zsh` ${USER}
