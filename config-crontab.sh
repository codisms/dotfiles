#!/bin/bash

echo "Add cron jobs..."
(crontab -u ${USER} -l 2>/dev/null; \
	echo "0 5 * * * ${HOME}/.dotfiles/bin/crontab-daily"; \
	echo "5 5 * * 1 ${HOME}/.dotfiles/bin/crontab-weekly"; \
	echo "15 5 1 * * ${HOME}/.dotfiles/bin/crontab-monthly") | crontab -u ${USER} -
