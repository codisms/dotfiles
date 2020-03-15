#zmodload zsh/zprof

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'
#alias ls='ls --color -AFh'
alias ls='ls -Fhs --color'
alias :q="cowsay -d 'You'\"'\"'re not running vim!'"
#alias jump='~/ssh_helper/jump.sh'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,node_modules} --line-number'
alias psql='sudo -u postgres psql'
#alias tmux0='tmux a -t 0'
if [ -f ~/.dircolors ]; then
	eval `dircolors ~/.dircolors`
fi

export EDITOR=vim
export DISABLE_AUTO_TITLE=true
export NODE_ENV=dev
export RACK_ENV=development
export PATH=$PATH:node_modules/.bin

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#setopt nosharehistory

[ -f ~/.profile ] && source ~/.profile

#if [ -f ~/.onstart ]; then
#	echo
#	echo
#	echo -e "\e[36m--[ .onstart ]-----------------------------------------------------------------------------------------------------------------------------\e[0m"
#	if [[ -x ~/.onstart ]]; then
#		~/.onstart
#	else
#		CMD=`cat ~/.onstart`
#		echo "Executing command: $CMD"
#		$CMD
#		CMD=
#	fi
#	rm ~/.onstart
#	echo -e "\e[36m-------------------------------------------------------------------------------------------------------------------------------------------\e[0m"
#	echo
#fi

#force_color_prompt=yes
#color_support=true
if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo -e "(\033[33m${BRANCH}${STAT}\033[0m)"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="✱${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo -e "\e[31m${bits}\e[0m"
	else
		echo ""
	fi
}

function get_short_pwd() {
	pwd | awk -F\/ '{ print $(NF-1), $(NF) }' | sed 's| |/|'
}

# set iTerm2 title
echo -ne "\033]0;${HOST}\007"

#set editing-mode vi
set -o vi
export PS1="`[ $(id -u) == "0" ] && echo -e '\033[31m'`\h\033[0m [\033[32m\`get_short_pwd\`\033[0m]\`parse_git_branch\` » "

