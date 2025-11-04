# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.

# VCS
MY_PROMPT_VCS_PROMPT_PREFIX1=" %{$reset_color%}on%{$fg[blue]%} "
MY_PROMPT_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
MY_PROMPT_VCS_PROMPT_SUFFIX="%{$reset_color%}"
MY_PROMPT_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
MY_PROMPT_VCS_PROMPT_CLEAN=" %{$fg[green]%}✓"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${MY_PROMPT_VCS_PROMPT_PREFIX1}git${MY_PROMPT_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$MY_PROMPT_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$MY_PROMPT_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$MY_PROMPT_VCS_PROMPT_CLEAN"

# SVN info
local svn_info='$(svn_prompt_info)'
ZSH_THEME_SVN_PROMPT_PREFIX="${MY_PROMPT_VCS_PROMPT_PREFIX1}svn${MY_PROMPT_VCS_PROMPT_PREFIX2}"
ZSH_THEME_SVN_PROMPT_SUFFIX="$MY_PROMPT_VCS_PROMPT_SUFFIX"
ZSH_THEME_SVN_PROMPT_DIRTY="$MY_PROMPT_VCS_PROMPT_DIRTY"
ZSH_THEME_SVN_PROMPT_CLEAN="$MY_PROMPT_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(MY_PROMPT_hg_prompt_info)'
MY_PROMPT_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${MY_PROMPT_VCS_PROMPT_PREFIX1}hg${MY_PROMPT_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [[ "$(hg config oh-my-zsh.hide-dirty 2>/dev/null)" != "1" ]]; then
			if [ -n "$(hg status 2>/dev/null)" ]; then
				echo -n "$MY_PROMPT_VCS_PROMPT_DIRTY"
			else
				echo -n "$MY_PROMPT_VCS_PROMPT_CLEAN"
			fi
		fi
		echo -n "$MY_PROMPT_VCS_PROMPT_SUFFIX"
	fi
}

# Virtualenv
local venv_info='$(virtenv_prompt)'
YS_THEME_VIRTUALENV_PROMPT_PREFIX=" %{$fg[green]%}"
YS_THEME_VIRTUALENV_PROMPT_SUFFIX=" %{$reset_color%}%"
virtenv_prompt() {
	[[ -n "${VIRTUAL_ENV:-}" ]] || return
	echo "${YS_THEME_VIRTUALENV_PROMPT_PREFIX}${VIRTUAL_ENV:t}${YS_THEME_VIRTUALENV_PROMPT_SUFFIX}"
}

local exit_code="%(?,,code:%{$fg[red]%}%?%{$reset_color%})"


setopt PROMPT_SUBST

# fast vpn status function
vpn_status() {
    local vpn_ip=$(ip -4 addr show tun0 2>/dev/null | awk '/inet / {print $2; exit}' | cut -d/ -f1)
    if [[ -n "$vpn_ip" ]]; then
        echo "─%{$fg_bold[red]%}[%{$fg[green]%}$vpn_ip%{$fg_bold[red]%}]─"
    else
      echo "─"
    fi
}


PROMPT="
%{$fg_bold[red]%}┌─\
%{$fg_bold[red]%}─[%{$reset_color%}\
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n)\
%{$reset_color%}@\
%{$fg[green]%}%m\
%{$reset_color%}%{$fg_bold[red]%}]\$(vpn_status)[%{$reset_color%}\
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
%{$fg_bold[red]%}]%{$reset_color%}\
${hg_info}\
${git_info}\
${svn_info}\
${venv_info}\
 \
$exit_code
%{$terminfo[bold]$fg[red]%}└── %{$reset_color%}\
%(?:%{$fg_bold[yellow]%}$ :%{$fg_bold[red]%}$ )%{$reset_color%}"
