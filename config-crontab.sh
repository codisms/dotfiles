#!/bin/bash

echo "Add cron jobs..."
(crontab -u ${USER} -l 2>/dev/null; \
	echo "0 5 * * * ${HOME}/.dotfiles/bin/crontab-daily 2>&1 | sudo tee -a /var/log/crontab-daily.log"; \
	echo "5 5 * * 1 ${HOME}/.dotfiles/bin/crontab-weekly 2>&1 | sudo tee -a /var/log/crontab-weekly.log"; \
	echo "15 5 1 * * ${HOME}/.dotfiles/bin/crontab-monthly 2>&1 | sudo tee -a /var/log/crontab-monthly.log") | crontab -u ${USER} -
