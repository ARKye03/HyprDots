#!/bin/bash

# Define a function to start a process if it's not already running
start_if_not_running() {
    if ! pgrep -f "$1" > /dev/null; then
        $1 &
    fi
}

# List of commands to check and start if not running
commands=(
    "$HOME/.dotfiles/scripts/WBG.lua random"
    "/usr/bin/dbus-update-activation-environment --all"
    "/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh"
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    "/usr/bin/nm-applet"
    "/usr/bin/copyq --start-server"
    "/usr/bin/hypridle"
    "/usr/bin/wl-clip-persist --clipboard regular"
    "/usr/bin/mpd-mpris --no-instance --host 127.0.0.1"
    "/usr/bin/ags"
)

# Iterate over the commands and start them if not already running
for cmd in "${commands[@]}"; do
    start_if_not_running "$cmd"
done