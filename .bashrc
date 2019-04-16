# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set up prompt including git branch.
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#PROMPT_COMMAND="__prompt_command; ${PROMPT_COMMAND}"
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

    if [ $exit != 0 ]; then
        PS1+="${Red}\u${RCol}"      # Add red if exit code non 0
    else
        PS1+="${Gre}\u${RCol}"
    fi

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in xterm*|rxvt*)
      echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
      ;;
    *)
      ;;
    esac

    PS1+="${BGre}@\h${RCol}:${BBlu}\w${BYel}$(parse_git_branch)${RCol}$ "
}



# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias ls='ls --color=auto'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f /usr/local/bin/fuck ]; then
  eval $(thefuck --alias)
fi

#Golang stuff

if [ -f /usr/local/bin/go ]; then
  export GOPATH=$(go env GOPATH)
  export PATH=$PATH:$(go env GOPATH)/bin
fi

export AWS_REGION=ap-southeast-2

# bash-my-aws
if [ -d ~/.bash-my-aws/lib/ ]; then
  for f in ~/.bash-my-aws/lib/*-functions; do source $f; done
  source ~/.bash-my-aws/bash_completion.sh
fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# proxy settings
if [ -f ~/.proxy-settings ]; then
  source ~/.proxy-settings
fi

source <(kubectl completion bash)
