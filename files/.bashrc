#!/bin/bash

# NOTE: We use bashism to minimize the number of process spawned

# {{{ preamble
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

function load() {
	[[ -r "$1" ]] && . "$1"
}
# }}}
# {{{ prompt
# load "$HOME/.bashrc.d/gentoo-prompt.sh"
PS1='\[\033[01;31m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
# }}}
# {{{ bash setting
HISTFILE=/dev/null
# }}}
# {{{ environment variable
export EDITOR=nvim
export VISUAL=nvim

export GPG_TTY=$(tty)

[[ "$EDITOR" == nvim ]] && export MANPAGER='nvim +Man!'
 
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

if [[ -x /usr/bin/ksshaskpass ]]; then
	export SSH_ASKPASS=/usr/bin/ksshaskpass
	export SSH_ASKPASS_REQUIRE=prefer
fi

if [[ -n $DBUS_SESSION_BUS_ADDRESS 
	&& -n $XDG_RUNTIME_DIR 
	&& $(systemctl is-active --user ssh-agent.service) == "active" ]]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi


if [[ -r $XDG_CONFIG_HOME/dircolor ]]; then
	if [[ $XDG_CONFIG_HOME/dircolor -nt $HOME/.bashrc.d/dircolor ]]; then
		dircolors -b "$XDG_CONFIG_HOME/dircolor" > "$HOME/.bashrc.d/dircolor"
	fi
	load "$HOME/.bashrc.d/dircolor"
fi

# }}}
# {{{ alias
alias vim=nvim
alias v=nvim

alias l='ls -lFh --color=auto'
alias l1='ls -1 --color=auto'
alias ll='ls -lFh --color=auto'
alias la='ls -lFha --color=auto'

alias g=git
alias gst='git status'
alias gc='git commit -v'
alias gca='git commit -v --amend'
alias gcs='git commit -v -S'
alias gcsa='git commit -v -S --amend'
alias gm='git merge'
alias gco='git checkout'
alias gcm='git checkout master || git checkout main'
alias gcb='git checkout -b'
alias gd='git diff'
alias gdw='git diff --word-diff'
alias gdc='git diff --cached'
alias ga='git add'
alias gau='git add -u'
alias gap='git add -p'
# }}}
# {{{ git
function git() {
	TZ=UTC command git "$@"
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
# }}}
# {{{ telemetry
export DOTNET_CLI_TELEMETRY_OPTION=1
# }}}

# vim: set foldmethod=marker:
