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

local_proxy_on() {
  export http_proxy=http://localhost:3128
  export HTTP_PROXY=http://localhost:3128
  export https_proxy=http://localhost:3128
  export HTTPS_PROXY=http://localhost:3128
}
local_proxy_off() {
  unset http_proxy
  unset HTTP_PROXY
  unset https_proxy
  unset HTTPS_PROXY
}

# curl a GCP API with your current access token
gapi_curl() {
  TOKEN=$(gcloud auth print-access-token)
  JSON=$(curl -s -H "Authorization: Bearer ${TOKEN}" "$@")
  echo $JSON | jq
}

# curl a GCP IAM protected endpoint
alias gcurl='curl --header "Authorization: Bearer $(gcloud config config-helper --format=value\(credential.id_token\))"'

# Set up prompt including git branch.
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

if [ -f /usr/local/bin/fuck ]; then
  eval $(thefuck --alias)
fi

#Golang stuff
if command -v go >/dev/null 2>&1; then
  export GOPATH=$(go env GOPATH)
  export PATH=$PATH:$(go env GOPATH)/bin
fi

export AWS_REGION=ap-southeast-2

# bash-my-aws
if [ -d ~/.bash-my-aws/lib/ ]; then
  for f in ~/.bash-my-aws/lib/*-functions; do source $f; done
  source ~/.bash-my-aws/bash_completion.sh
fi

# proxy settings
if [ -f ~/.proxy-settings ]; then
  source ~/.proxy-settings
fi

if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion bash)
fi

# docker for windows
if uname -r | grep Microsoft > /dev/null; then
  export DOCKER_HOST=localhost:2375
fi

