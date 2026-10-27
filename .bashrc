# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set up prompt including git branch.
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

virtualenv_name() {
  if [[ -n $VIRTUAL_ENV ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}

PROMPT_COMMAND=__prompt_command

__prompt_command() {
  local exit="$?"             # This needs to be first
  PS1=""

  local RCol='\[\e[0m\]'

  local Red='\[\e[0;31m\]'
  local Gre='\[\e[0;32m\]'
  local BGre='\[\e[1;32m\]'
  local BYel='\[\e[1;33m\]'
  local BBlu='\[\e[1;34m\]'
  local BCya='\[\e[1;36m\]'

  if [ $exit != 0 ]; then
    PS1+="${Red}\u${RCol}"      # Add red if exit code non 0
  else
    PS1+="${Gre}\u${RCol}"
  fi

  PS1+="${BGre}@\h${RCol}:${BBlu}\w${BYel}$(parse_git_branch)${BCya}$(virtualenv_name)${RCol}$ "
}

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# programmable completion (Linux, then Homebrew's bash-completion@2)
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
elif [ -n "$HOMEBREW_PREFIX" ] && [ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]; then
  . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
fi

if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion bash)
fi

if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --bash 2>/dev/null)"
fi
