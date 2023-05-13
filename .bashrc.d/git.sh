function dotfile() {
	local args=(
		--git-dir "$DOTFILES_DIR/.git"
	)

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

load /usr/share/git/completion/git-completion.bash
if [ "$(type -t __git_complete)" = function ]; then
	# Add all git aliases to completion
	# It's a bit too hard-coded however...
	for alias in $(alias | cut -d ' ' -f 2 | cut -d = -f 1); do
		git_alias_complete=''
		case "$alias" in
			g)      git_alias_complete=git;;
			gst)    git_alias_complete=git_status;;
			ga|ga?) git_alias_complete=git_add;;
			gd|gd?) git_alias_complete=git_diff;;
			gm|gm?) git_alias_complete=git_merge;;
			gd|gd?) git_alias_complete=git_diff;;
			gc|gcs) git_alias_complete=git_commit;;
			gc?)    git_alias_complete=git_checkout;;

			*) continue;;
		esac
		__git_complete "$alias" "$git_alias_complete"
	done
	unset git_alias_complete

	__git_complete dotfile git
fi
