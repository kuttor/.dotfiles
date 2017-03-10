# check that we're in the shell and not in something like vim terminal
if [[ "$0" == *"zsh" ]]; then
  # Use caching for commands that would like a cache.
  zstyle ':completion:*' use-cache true
  zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/.zcache"

  # --------------------------------------------------------------------------
  # Completion display
  # --------------------------------------------------------------------------

  # group all by the description above
  zstyle ':completion:*' group-name ''

  # colorful completion
  #zstyle ':completion:*' list-colors ''

  # Updated to respect LS_COLORS
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

  zstyle ':completion:*' list-dirs-first yes

  # go into menu mode on second tab (like current vim wildmenu setting)
  # only if there's more than two things to choose from
  zstyle ':completion:*' menu select=2

  # show descriptions for options
  zstyle ':completion:*' verbose yes

  # in Bold, specify what type the completion is, e.g. a file or an alias or
  # a cmd
  zstyle ':completion:*:descriptions' format '%F{black}%B%d%b%f'

  # --------------------------------------------------------------------------
  # Results matching
  # --------------------------------------------------------------------------

  # use case-insensitive completion if case-sensitive generated no hits
  zstyle ':completion:*' matcher-list \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

  # don't complete usernames
  zstyle ':completion:*' users ''

  # don't autocomplete homedirs
  zstyle ':completion::complete:cd:*' tag-order '! users'

  # --------------------------------------------------------------------------
  # Result output transformation
  # --------------------------------------------------------------------------

  # expand completions as much as possible on tab
  # e.g. start expanding a path up to wherever it can be until error
  zstyle ':completion:*' expand yes

  # colorful kill command completion
  zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

  # process names
  zstyle ':completion:*:processes-names' command  'ps c -u ${USER} -o command | uniq'

  # SSH use hosts from ~/.ssh/config
  [ -f "$HOME/.ssh/config" ] && {
    hosts=($(egrep '^Host ' "$HOME/.ssh/config" | grep -v '*' | awk '{print $2}' ))
    zstyle ':completion:*:hosts' hosts $hosts
  }
fi
