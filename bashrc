#zmodload zsh/zprof

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'
#alias ls='ls --color -AFh'
alias ls='ls -Fhs --color'
#alias jump='~/ssh_helper/jump.sh'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,node_modules} --line-number'
alias psql='sudo -u postgres psql'
alias tmux0='tmux a -t 0'
if [ -f ~/.dircolors ]; then
	eval `dircolors ~/.dircolors`
fi

export EDITOR=vim
export DISABLE_AUTO_TITLE=true
export NODE_ENV=dev
export RACK_ENV=development
export PATH=$PATH:node_modules/.bin

[ -f ~/.profile ] && source ~/.profile

if [ -f ~/.onstart ]; then
	echo
	echo
	echo -e "\e[36m--[ .onstart ]-----------------------------------------------------------------------------------------------------------------------------\e[0m"
	if [[ -x ~/.onstart ]]; then
		~/.onstart
	else
		CMD=`cat ~/.onstart`
		echo "Executing command: $CMD"
		$CMD
		CMD=
	fi
	rm ~/.onstart
	echo -e "\e[36m-------------------------------------------------------------------------------------------------------------------------------------------\e[0m"
	echo
fi
