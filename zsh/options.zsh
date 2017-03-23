#!/usr/bin/env zsh
# zoptions
# by: Andrew Kuttor

#============================================================================
# Command-line Enhancers
#============================================================================

# Navigation
setopt AUTO_CD      # Auto inserts CD so you dont have to
setopt CDABLE_VARS      # Attempt expansion unless dir or /

# Complete methods
setopt COMPLETE_IN_WORD # Mid-word completion
setopt ALWAYS_TO_END    # Move to end-of-word after complete
setopt extended_glob    # Adds #, ^, ~ as potential patterns

COMPLETION_WAITING_DOTS="true"
DISABLE_CORRECTION="true"

# Highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(\
    main brackets pattern cursor root line)

# Autosuggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=136"
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(\
    do_enter kill-line $ZSH_AUTOSUGGEST_CLEAR_WIDGETS)

# Trapd00r LS Colors
export CLICOLOR=YES
eval $(gdircolors -b "$HOME/.dircolors")

#============================================================================
# Prompt
#============================================================================

# Prompt expansions powers
setopt PROMPT_SUBST

# Load prompt
autoload -U promptinit
promptinit && prompt pure

#============================================================================
# Help
#============================================================================

# Hotkey: Meta+h for current command
autoload run-help

# Auto-Help responses
autoload run-help-sudo
autoload run-help-git
autoload run-help-openssl
autoload run-help-ip

# Enabled math functions
zmodload zsh/mathfunc

