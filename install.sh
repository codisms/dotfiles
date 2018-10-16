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

echo -e "\e[35mCreating symlinks...\e[0m"
if [ -f .dircolors ]; then
	mv .dircolors .dircolors.disabled
fi
ln -s ./.dotfiles/repos/dircolors-solarized/dircolors.256dark .dircolors
if [ -f .zshrc ]; then
	mv .zshrc .zshrc.disabled
fi
ln -s ./.dotfiles/zshrc .zshrc
if [ -f .gitconfig ]; then
	mv .gitconfig .gitconfig.disabled
fi
ln -s ./.dotfiles/gitconfig .gitconfig
if [ -f .elinks ]; then
	mv .elinks .elinks.disabled
fi
ln -s ./.dotfiles/elinks .elinks
if [ -f .muttrc ]; then
	mv .muttrc .muttrc.disabled
fi
ln -s ./.dotfiles/muttrc .muttrc
if [ -f .ctags ]; then
	mv .ctags .ctags.disabled
fi
ln -s ./.dotfiles/ctags .ctags
if [ -f .eslintrc ]; then
	mv .eslintrc .eslintrc.disabled
fi
ln -s ./.dotfiles/eslintrc .eslintrc
if [ -f .editorconfig ]; then
	mv .editorconfig .editorconfig.disabled
fi
ln -s ./.dotfiles/editorconfig .editorconfig
if [ -f .psqlrc ]; then
	mv .psqlrc .psqlrc.disabled
fi
ln -s ./.dotfiles/psqlrc .psqlrc

echo -e "\e[35mSetting zsh as default shell...\e[0m"
[ -f /etc/ptmp ] && $SUDO rm -f /etc/ptmp
$SUDO chsh -s `which zsh` ${USER}

echo -e "\e[35mDownloading antigen modules...\e[0m"
zsh -c "source ~/.zshrc"

