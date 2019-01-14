#!/usr/local/bin/zsh
# Name: Andrew Kuttor
# Mail: andrew.kuttor@gmail.com

# -----------------------------------------------------------------------------

# Dotfiles location
export DOTFILES="${HOME}/.dotfiles"

# Functions
fpath=( $fpath "${DOTFILES}/functions" )
autoload -U "${DOTFILES}/functions"

# Language
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# Prompt
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=143'

# Editor
export EDITOR=`which nvim`
export VISUAL="${EDITOR}"
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"

# Pager
export PAGER='bat'
export MANPAGER='bat'
export BAT_CONFIG_PATH="${DOTFILES}/bat.conf"

# EnhancedCD
export ENHANCD_DOT_SHOW_FULLPATH=1
export ENHANCD_FILTER="/usr/local/bin/fzf:fzf-tmux:fzf:percol"

# Auto-Fu-map-syntax .ignore:.gitignore
[[ -f "${ZPLUG}/HOME/repos/hchbaw/auto-fu.zsh" ]]&&\
source "${ZPLUG}/HOME/repos/hchbaw/auto-fu.zsh/auto-fu.zsh"

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

#zle-line-init () {auto-fu-init;}; zle -N zle-line-init

zle -N zle-line-init
zle -N zle-keymap-select auto-fu-zle-keymap-select
zstyle ':completion:*' completer _oldlist _complete

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# ----------------------------------------------------------------------------
# Powertool configs, i.e. FZ, FZF
# -----------------------------------------------------------------------------

# Source FZF
[[ -f "${HOME}/.local/.fzf.zsh" ]] && source "${HOME}/.local/.fzf.zsh"

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
function _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
function _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Sources
source "${DOTFILES}/aliases"
source "${DOTFILES}/functions"
source "${DOTFILES}/keybindings"
source "${DOTFILES}/zplugs"
source "${DOTFILES}/zsh_autoloads"
source "${DOTFILES}/zsh_completions"
source "${DOTFILES}/zsh_history"
source "${DOTFILES}/zsh_setopts"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

