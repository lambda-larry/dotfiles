#!/bin/bash

unset SHLVL

spawn() {
	$@ 2>/dev/null & disown
}

[[ -r ~/.screenlayout/default.sh ]] && spawn sh ~/.screenlayout/default.sh
[[ -r ~/.fehbg                   ]] && spawn sh ~/.fehbg

DWM=dwm

spawn picom -b
spawn nm-applet
spawn blueman-applet
spawn pasystray
spawn slstatus
spawn flameshot

setxkbmap -option grp:alt_shift_toggle -layout us,dk
xrdb ~/.config/X11/Xresources

if [[ -z "$SSH_AUTH_SOCK" ]]; then
	exec ssh-agent dbus-run-session $DWM
else
	exec dbus-run-session $DWM
fi

