#!/usr/bin/env bash

export EDITOR=nvim
export VISUAL=nvim

export GPG_TTY=$(tty)

[ "$EDITOR" == nvim ] && export MANPAGER='nvim +Man!'

# XDG configuration
export XDG_CONFIG_HOME="$HOME/.config"
if [ "$UID" != 0 ] && [ -f "$XDG_CONFIG_HOME/user-dirs.dirs" ]; then
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
export CARGO_HOME="$XDG_DATA_HOME"/cargo

export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# Disable bash history
HISTFILE=/dev/null

DOTFILES_DIR="$HOME/dotfiles"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$CARGO_HOME/bin:$PATH"
