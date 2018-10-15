ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✱"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_SVN_PROMPT_PREFIX=$ZSH_THEME_GIT_PROMPT_PREFIX
ZSH_THEME_SVN_PROMPT_SUFFIX=$ZSH_THEME_GIT_PROMPT_SUFFIX
ZSH_THEME_SVN_PROMPT_DIRTY=$ZSH_THEME_GIT_PROMPT_DIRTY
ZSH_THEME_SVN_PROMPT_CLEAN=$ZSH_THEME_GIT_PROMPT_CLEAN

vcs_status() {
    if [[ ( $(whence in_svn) != "" ) && ( $(in_svn) == 1 ) ]]; then
        svn_prompt_info
    else
        git_prompt_info
    fi
}

_host_name() {
	#echo $(hostname)
	if [[ "$(hostname)" =~ '.*\.local$' ]]; then
		echo "\e[5m%m\e[25m"
	else
		echo "%m"
	fi
}

PROMPT='$(_host_name) [%{$fg[green]%}%2~%{$reset_color%}]$(vcs_status) $(vi_mode_prompt_info)»%b '
MODE_INDICATOR=" %{$fg[magenta]%}»%{$reset_color%}%{$fg_bold[magenta]%}»%{$reset_color%}"
RPS1=""
#RPS1='$(vi_mode_prompt_info) ${return_code}'
#MODE_INDICATOR="%{$fg_bold[magenta]%}<%{$reset_color%}%{$fg[magenta]%}<<%{$reset_color%}"

