#!/usr/bin/env bash

set -e # stop on error

if [[ ! -f configure.sh ]]; then
	if [[ -d ~/.dotfiles ]]; then
		echo "The folder ~/.dotfiles already exists"
		exit 1
	fi

	echo "Downloading dotfiles for the first time"
	git clone https://github.com/codisms/env-config.git ~/.dotfiles

	cd ~/.dotfiles || exit 1
fi

[[ -d .git ]] && git submodule update --init --recursive --remote --force --depth 1

./configure.sh "$@"
