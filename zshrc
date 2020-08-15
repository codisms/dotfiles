#zmodload zsh/zprof

source ~/.dotfiles/repos/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle gitfast
#antigen bundle gitfast
antigen bundle akoenig/gulp.plugin.zsh
#antigen bundle vi-mode
#antigen theme minimal
antigen apply
source ~/.dotfiles/codisms.zsh-theme

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

setopt nosharehistory

[ -f ~/.profile ] && source ~/.profile

bindkey -v
export KEYTIMEOUT=1

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$bg[yellow]%}%{$fg[black]%} [%  VIM ]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

#compdef -d git

#zprof

function lazygit() {
	git add . && git commit -m "$1" && git push
}

#function override_git() {
#	cmd=$1
#	shift
#	extra=""
#	if [[ "$cmd" == "diff" ]]; then
#		cmd="my-diff"
#		#extra="--color-words --ignore-all-space"
#	#elif [ "$cmd" == "rm" ]; then
#	#	extra="--cached"
#	fi
#	echo "$original_git" "$cmd" "$extra" "$@"
#	"$original_git" $cmd $extra $@
#}
#
#unalias git 2> /dev/null
#original_git=`which git`
##echo $original_git
#alias git='override_git'

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

# set iTerm2 title
echo -ne "\033]0;${HOST}\007"

#export PATH="$PATH:$HOME/.rvm/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if [[ $- == *i* ]]; then
	stty -ixon
fi

autoload -U +X bashcompinit && bashcompinit
source <(kubectl completion zsh)
complete -o nospace -C /usr/bin/terraform terraform
