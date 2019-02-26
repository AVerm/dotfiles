# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# load the keyboard definitions
XKBDIR="$HOME/.xkb"
XKBMAPFILE="$XKBDIR/keymap/my_configuration"
# DISPLAY should be defined at this point by X.
# The POSIX pattern removal %%.* removes a trailing "." followed by
# any number of characters from the DISPLAY value.
# (Ignores warnings)
xkbcomp -w 0 -I"$XKBDIR" "$XKBMAPFILE" "${DISPLAY%%.*}"
unset XKBDIR XKBMAPFILE
# The keyboard definitions have now been loaded.
