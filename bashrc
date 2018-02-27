#! /bin/bash

# Author: Andrew Kuttor
# E-mail: andrew.kuttor@gmail.com

# ==============================================================================
# Terminal
# ==============================================================================

# Absolute path to this script, e.g. /home/user/bin/foo.sh
DOTFILES="$(dirname $(readlink -f $BASH_SOURCE))/"
# DOTFILES="$HOME/Code

# Set current user perms +rwrite 
umask 022

# Extend Less filetype compatabilities
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Give LS filetypes lots of colors
# eval $(dircolors -b ~/Code/dotfiles/dircolors)

# Hub: https://github.com/github/hub
eval "$(hub alias -s)"

# Tilix VTE
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source "/etc/profile.d/vte.sh"
fi

xhost +local:root > /dev/null 2>&1

# 
if [ -t 1  ]; then
  cd ~
fi

# More compact prompt
# PS1='\e[37;1m\u@\e[35m\W\e[0m\$ '


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
# Completions
# ==============================================================================

# Programmable completions
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi

# Bash Completions
. /usr/share/bash-completion/bash_completion

# Sudo
complete -cf sudo

# SSH hostnames
[ -e "$HOME/.ssh/config" ] && \
    complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config |\
    grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# FZF completions 
complete -F _fzf_path_completion -o default -o bashdefault tree
complete -F _fzf_path_completion -o default -o bashdefault ag

# ==============================================================================
# fzf
# ==============================================================================

# Use ~~ as the trigger sequence instead of the default ** 
export FZF_COMPLETION_TRIGGER='~~'

#Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

# Use ag instead of the default find command for listing candidates.
# - The first argument to the function is the base path to start traversal
# - Note that ag only lists files not directories
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {   ag -g "" "$i1" ; }

# ==============================================================================
# Sources
# ==============================================================================

[[ -f "$DOTFILES/bash_functions" ]] && . "$DOTFILES/bash_functions"
[[ -f "$DOTFILES/aliases" ]] && . "$DOTFILES/aliases"
[[ -f "$DOTFILES/bash_history" ]] && . "$DOTFILES/bash_history"
[[ -f "$DOTFILES/exports" ]] && . "$DOTFILES/exports"
#[[ -f "$DOTFILES/inputrc" ]] && bind -f "$DOTFILES/inputrc"



