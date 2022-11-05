# Wrapper function for git
function git() {
	local args=()

	# Use dotfiles repo as default if cwd is not a git repo and is inside
	# home.
	if [[ $PWD =~ ^$HOME ]] && ! command git status >/dev/null 2>/dev/null; then
		args+=(--git-dir "$DOTFILES_DIR/.git")
	fi

	# If no command has been supplied, use status as default.
	if [ $# = 0 ]; then
		args+=(status)
	fi

	command git "${args[@]}" "$@"
}

load /usr/share/git/git-prompt.sh

if [ "$(type -t __git_ps1)" = function ] && ! [[ $PS1 =~ __git_ps1 ]]; then
	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWSTASHSTATE=true
	GIT_PS1_SHOWUNTRACKEDFILES=true
	GIT_PS1_SHOWUPSTREAM=auto,verbose,name
	GIT_PS1_SHOWCONFLICTSTATE=true
	GIT_PS1_SHOWCOLORHINTS=true
	PS1="\$(__git_ps1 '[%s] ')$PS1"
fi
