#!/usr/bin/env zsh
# vim:set ft=zsh ts=2 sw=2 sts=0

# file: zshrc
# info: main configuration file
# name: andrew kuttor
# mail: andrew.kuttor@gmail.com1

TRAPWINCH() { zle && { zle reset-prompt; zle -R }}
export ZSH="$HOME/.dotfiles/zsh"
limit coredumpsize 0
skip_global_compinit=1

# Sources
source "$ZSH/zinit"
source "$ZSH/setopts"
source "$ZSH/env"
source "$ZSH/aliases"
source "$ZSH/completes"
source "$ZSH/keybind"

# Prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

