#! /bin/bash

# Author: Andrew Kuttor
# E-mail: andrew.kuttor@gmail.com

# ==============================================================================
# Terminal
# ==============================================================================

# Absolute path to this script, e.g. /home/user/bin/foo.sh
# SCRIPT_DIR="$(dirname $(readlink -f $BASH_SOURCE))/"`
SCRIPT_DIR="$HOME/.dotfiles"

# If not interactive do not pass go
case $- in
	*i*) ;;
	*) return;;
esac

# Promotes faster Terminal starts
sudo rm -rf /private/var/log/asl/*.asl

# Assigns perms so that current user only has read and write access
umask 022

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ==============================================================================
# Shopt
# ==============================================================================

shopt -s autocd         # Auto cd when navigating file system
shopt -s nocaseglob     # Case in-sensitive globbing
shopt -s cdspell        # Autocorrect typos in path when using cd
shopt -s checkwinsize   # Checks/Modifies term window size per command
shopt -s progcomp       # Programmable completions
shopt -s expand_aliases # Expands aliases while in use

# ==============================================================================
# Special
# ==============================================================================

# Hub: https://github.com/github/hub
eval "$(hub alias -s)"

# Tilix VTE
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source "/etc/profile.d/vte.sh"
fi

# ==============================================================================
# Completions
# ==============================================================================

# Enable programmable completions
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Tab completions with sudo
complete -cf sudo

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && \
    complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config |\
    grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# FZF
. "/usr/share/fzf/completion.bash"

# ==============================================================================
# Keybindings
# ==============================================================================

# FZF
. "/usr/share/fzf/key-bindings.bash"

# ==============================================================================
# Sources
# ==============================================================================

[[ -f "$SCRIPT_DIR/bash_functions" ]] && . "$SCRIPT_DIR/bash_functions"
[[ -f "$SCRIPT_DIR/bash_aliases" ]] && . "$SCRIPT_DIR/bash_aliases"
[[ -f "$SCRIPT_DIR/bash_history" ]] && . "$SCRIPT_DIR/bash_history"
[[ -f "$SCRIPT_DIR/exports" ]] && . "$SCRIPT_DIR/exports"
[[ -f "$SCRIPT_DIR/colors" ]] && . "$SCRIPT_DIR/colors"
[[ -f "$SCRIPT_DIR/../inputrc" ]] && bind -f "$SCRIPT_DIR/inputrc"
