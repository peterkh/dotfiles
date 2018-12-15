# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

# set PATH so it includes user's private scripts if it exists
if [ -d ~/scripts ] ; then
    PATH=~/scripts:"${PATH}"
fi

export EDITOR='/usr/bin/vim'

alias cls='clear'
alias grpe='grep'
alias la='ls -a'
alias latr='ls -latr'
alias ll='ls -la'
alias ls='ls --color=auto'
alias vi='vim'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

