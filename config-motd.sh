#!/bin/bash

SUDO=$(which sudo 2> /dev/null)

echo -e "\e[35mSetting up motd...\e[0m"
[ -f /etc/motd ] && $SUDO mv /etc/motd /etc/motd.orig
$SUDO ln -s ${HOME}/.dotfiles/motd /etc/motd
