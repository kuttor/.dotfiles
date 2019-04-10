#!/usr/local/bin/zsh -f
# -*- coding: utf-8 -*-

# file: zplug.zsh
# info: Zplug config file to init, load, and install Zsh/Zplug plugins
# name: Andrew Kuttor
# mail: andrew.kuttor@gmail.com

# Check if zplug is installed
[ -d "$HOME/.zplug" ] && hub clone "zplug/zplug" "$HOME/.zplug"

# Load Zplug
source "$ZPLUG_HOME/init.zsh"

zplug "mafredri/zsh-async"
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug "djui/alias-tips"
zplug "tysonwolker/iterm-tab-colors"
zplug "changyuheng/zsh-interactive-cd"
zplug "knu/zsh-manydots-magic"
zplug "chrissicool/zsh-bash", from:oh-my-zsh
zplug "github/hub", from:github
zplug "hlissner/zsh-autopair"
zplug "peco/peco",          as:command, from:gh-r
zplug "rupa/z", use:z.sh
zplug "skywind3000/z.lua"
zplug "junegunn/fzf", as:command, hook-build:"./install --bin", use:"bin/{fzf-tmux,fzf}"
zplug "andrewferrier/fzf-z"
zplug "aperezdc/zsh-fzy"
zplug "jimeh/zsh-peco-history", defer:2, hook-build:'ZSH_PECO_HISTORY_DEDUP=1'
zplug "ytet5uy4/fzf-widgets", hook-load:'FZF_WIDGET_TMUX=1'

# Let Zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# From Oh-My-ZSH
zstyle ":zplug:tag" from oh-my-zsh
zplug "lib/clipboard",            if:"[[ $OSTYPE == *darwin* ]]"
zplug "plugins/osx"               if:"[[ $OSTYPE == *darwin* ]]"
zplug "plugins/colored-man-pages"
zplug "plugins/virtualenv"
zplug "plugins/zsh_reload"
zplug "plugins/completion"
zplug "plugins/sudo"
zplug "plugins/git",              if:"(( $+commands[git] ))"
zplug "plugins/gitignore",        if:"(( $+commands[git] ))"
zplug "plugins/git-prompt",       if:"(( $+commands[git] ))"
zplug "plugins/nmap",             if:"(( $+commands[nmap] ))"
zplug "plugins/pip",              if:"(( $+commands[pip] ))"
zplug "plugins/pyenv",            if:"(( $+commands[pyenv] ))"
zplug "plugins/pylint",           if:"(( $+commands[pylint] ))"
zplug "plugins/python",           if:"(( $+commands[python] ))"
zplug "plugins/sudo",             if:"(( $+commands[sudo] ))"
zplug "plugins/thefuck",          if:"(( $+commands[thefuck] ))"

# zsh users
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

# -----------------------------------------------------------------------------

# History EnhanCD
if zplug check "b4b4r07/zsh-history-enhanced"; then
    ZSH_HISTORY_FILE="$HISTFILE"
    ZSH_HISTORY_FILTER="fzf:peco:percol"
    ZSH_HISTORY_KEYBIND_GET_BY_DIR="^r"
    ZSH_HISTORY_KEYBIND_GET_ALL="^r^a"
fi

# Spaceship Prompt
if zplug check "denysdovhan/spaceship-prompt"; then
    SPACESHIP_PROMPT_ORDER=(
    user          # Username section
    dir           # Current directory section
    host          # Hostname section
    git           # Git section (git_branch + git_status)
    exec_time     # Execution time
    line_sep      # Line break
    battery       # Battery level and status
    jobs          # Background jobs indicator
    char          # Prompt character
    )

    SPACESHIP_RPROMPT_ORDER=(
    exit_code
    time
    )

    SPACESHIP_TIME_SHOW=true
    SPACESHIP_EXIT_CODE_SHOW=true
    SPACESHIP_PROMPT_SEPARATE_LINE=false
    SPACESHIP_PROMPT_ADD_NEWLINE=true
fi

# History Substring Search
if zplug check "zsh-users/zsh-history-substring-search"; then
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='underline'
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=default,fg=9'
fi

# Autosuggestion
if zplug check "zsh-users/zsh-autosuggestions"; then
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=212'
    ZSH_AUTOSUGGEST_USE_ASYNC=1
fi

#if zplug check "zsh-users/zsh-syntax-highlighting"; then
#    #ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=red'
#    ZSH_HIGHLIGHT_STYLES[globbing]='fg=green'
#    ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=green'
#    ZSH_HIGHLIGHT_STYLES[path_approx]='fg=yellow'
#    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta'
#fi



# -----------------------------------------------------------------------------

# zplug check returns true if all packages are installed
zplug check || zplug install

# source plugins and add commands to the PATH
zplug load
