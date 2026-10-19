#!/bin/bash

unset SHLVL

[[ -r ~/.screenlayout/default.sh ]] && sh ~/.screenlayout/default.sh
[[ -r ~/.fehbg                   ]] && sh ~/.fehbg

WM=${1:-$WM}
WM=${WM:-dwm}

LAUNCHERS=()

if [[ -z "$SSH_AUTH_SOCK" ]]; then
	LAUNCHERS+=(ssh-agent)
fi

LAUNCHERS+=(dbus-run-session)

setxkbmap -option grp:alt_shift_toggle -layout us
xrdb ~/.config/X11/Xresources

exec "${LAUNCHERS[@]}" bash <(cat << BASH
spawn() {
	\$@ 2>/dev/null & disown
}
spawn picom -b
spawn nm-applet
spawn blueman-applet
spawn pasystray
spawn slstatus
spawn flameshot

exec $WM
BASH
)
