#!/usr/local/bin/zsh
#
# file  : history.zsh
# info  : Extended history configurations for dotfiles
# name  : Andrew Kuttor
# mail  : andrew.kuttor@gmail.com

# -----------------------------------------------------------------------------
# Options
# -----------------------------------------------------------------------------

setopt BANG_HIST                 # Treat '!' char specially during expansion.
setopt EXTENDED_HISTORY          # Use history ":start:elapsed;command" format.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
setopt HIST_EXPIRE_DUPS_FIRST    # Remove dupes first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS      # Delete old entry if new entry is a dupe.
setopt HIST_IGNORE_DUPS          # Don't record what was just recorded again.
setopt HIST_IGNORE_SPACE         # Don't record starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording.
setopt HIST_SAVE_NO_DUPS         # Don't write dupes in the history file.
setopt HIST_VERIFY               # Don't execute immediately upon expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately.
setopt SHARE_HISTORY             # Share history between all sessions.

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
alias h="history"

# -----------------------------------------------------------------------------
# backward/forward search
# -----------------------------------------------------------------------------
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# -----------------------------------------------------------------------------
# Env Vars
# -----------------------------------------------------------------------------

HISTFILE=$CACHE/.zsh_history
HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
HISTSIZE=10000
SAVEHIST=10000

# Add timestamps
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

# Power History command with FZF integration
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) |\
      fzf +s --tac |\
      sed 's/ *[0-9]* *//')
}

