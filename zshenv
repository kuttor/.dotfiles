#!/usr/local/bin/zsh
# vim:set ft=zsh ts=4 sw=4 sts=0 foldmethod=marker:
# -----------------------------------------------------------------------------
# file: zshenv
# info: Main config file for env variables 
# name: Andrew Kuttor
# mail: andrew.kuttor@gmail.com
# -----------------------------------------------------------------------------

# ENV VAR
ZDOTDIR="$HOME/.zsh"
export DOTFILES="$HOME/.dotfiles"
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# fpath
typeset -U fpath
fpath=(
  ${ZSH_HOME}/site-functions
  ${DOTFILES}/functions
  ${fpath}
)

# SYSTEM PATHS
typeset -U path
path=(
  /usr/local/{bin,sbin}(N-/)
  /usr/{bin,sbin}(N-/)
  /{bin,sbin}(N-/)
  /usr/local/lib/python2.7/site-packages(N-/)
  /usr/local/lib/python3.7/site-packages(N-/)
  $path
)

# LANGUAGE
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# TERMINAL
export KEYTIMEOUT=1
export TERMINAL_DARK=1
export CLICOLOR=1
export LSCOLORS=exgxcxdxcxegedabagacad
export _Z_DATA="$HOME/.config/z-data"
export ITERM_24BIT=1
export WORDCHARS='*?-[]~\!#%^(){}<>|`@#%^*()+:?'

# EDITOR
export EDITOR=`which vim`
export VISUAL="${EDITOR}"
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"

# FZF 
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# HOMEBREW
export HOMEBREW_GITHUB_API_TOKEN=aed27538de34dd4e7df7d5672c538f693f1109a0

# Pager
export PAGER='bat'
export MANPAGER='bat'
export BAT_CONFIG_PATH="${DOTFILES}/bat.conf"

# ENHANCD
export ENHANCD_FILTER="fzf --height 50% --reverse --ansi"
export ENHANCD_DOT_SHOW_FULLPATH=1

# MOLECULE
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

skip_global_compinit=1
# vim:set ft=zsh ts=4 sw=4 sts=0
