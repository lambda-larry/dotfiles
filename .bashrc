# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

function load() {
	[ -f "$1" ] && . "$1"
}

load "$HOME/.bashrc.d/gentoo-prompt.sh"
load "$HOME/.bashrc.d/env.sh"
load "$HOME/.bashrc.d/alias.sh"
load "$HOME/.bashrc.d/git.sh"
load "$HOME/.bashrc.d/zfsbootmenu.sh"
load "$HOME/.bashrc.d/telemetry.sh"

unset load
