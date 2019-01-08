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

# Python stuff
export PATH=~/Library/Python/2.7/bin/:$PATH
export PATH=~/Library/Python/3.7/bin/:$PATH
export WORKON_HOME=~/virtualenvs
if [ -f ~/Library/Python/2.7/bin/virtualenvwrapper.sh ]; then source ~/Library/Python/2.7/bin/virtualenvwrapper.sh; fi
if [ -f ~/Library/Python/3.7/bin/virtualenvwrapper.sh ]; then
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
  source ~/Library/Python/3.7/bin/virtualenvwrapper.sh
fi

export GEM_HOME=~/.gem
export PATH=~/.gem/bin:$PATH
PATH="/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/google-cloud-sdk/path.bash.inc ]; then source ~/google-cloud-sdk/path.bash.inc; fi

# The next line enables shell command completion for gcloud.
if [ -f ~/google-cloud-sdk/completion.bash.inc ]; then source ~/google-cloud-sdk/completion.bash.inc; fi


# get the cert from an endpoint
ssl_cert() {
        CLUSTER_IP=$(gcloud container clusters list --format json|jq -r .[0].privateClusterConfig.publicEndpoint)
        >&2 echo "Getting cert for cluster endpoint $CLUSTER_IP"
        echo | openssl s_client -connect $CLUSTER_IP:443 -proxy localhost:3128 2>&1 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
}

alias kcu_digio='kubectl config use-context gke_digio'
alias kcu_peterkh='kubectl config use-context gke_peterkh'

