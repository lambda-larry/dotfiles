#!/usr/bin/env bash

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/go/bin:$PATH"

export EDITOR=nvim
export VISUAL=nvim

export GPG_TTY=$(tty)

[ "$EDITOR" == nvim ] && export MANPAGER='nvim +Man!'

# XDG configuration
export XDG_CONFIG_HOME="$HOME/.config"
if [ -f "$XDG_CONFIG_HOME/user-dirs.dirs" ]; then
	. "$XDG_CONFIG_HOME/user-dirs.dirs"
	for var in $(grep -v '#' "$XDG_CONFIG_HOME/user-dirs.dirs" | cut -d = -f 1); do
		export $var
	done
	unset var
fi


export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"


export GOPATH="$XDG_DATA_HOME"/go

# Disable bash history
HISTFILE=/dev/null

DOTFILES_DIR="$HOME/dotfiles"
