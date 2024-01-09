switch (uname -s)
case Darwin
  set HOME_BREW_PREFIX (/opt/homebrew/bin/brew --prefix)
  set -x PATH /usr/local/bin/ $PATH
  set -x PATH /usr/local/sbin/ $PATH
  set -x PATH ~/Library/Python/2.7/bin/ $PATH
  set -x PATH ~/Library/Python/3.7/bin/ $PATH
  set -x PATH $HOME_BREW_PREFIX/opt/coreutils/libexec/gnubin $PATH
  set -x PATH $HOME_BREW_PREFIX/opt/grep/libexec/gnubin $PATH
  set -x PATH $HOME_BREW_PREFIX/opt/postgresql@11/bin $PATH
  set -x PATH $HOME_BREW_PREFIX/opt/gnu-which/libexec/gnubin $PATH
  set -x PATH $HOME_BREW_PREFIX/opt/gnu-tar/libexec/gnubin $PATH
  set -x PATH $HOME_BREW_PREFIX/opt/gnu-sed/libexec/gnubin $PATH
  set -x PATH $HOME_BREW_PREFIX/bin $PATH
  set -x PATH $HOME_BREW_PREFIX/sbin $PATH
  set -x PATH "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" $PATH
  set -x PATH /usr/local/share/dotnet $PATH
  set -x PATH ~/.dotnet/tools $PATH
case Linux
  set -x PATH ~/.local/bin $PATH
  if test -d ~/.pyenv
    set -x PYENV_ROOT $HOME/.pyenv
    set -x PATH $PYENV_ROOT/bin $PATH
  end
  if test -d /usr/local/go
    set -x PATH /usr/local/go/bin $PATH
  end
  if test -d ~/.dotnet/tools
    set -x PATH $HOME/.dotnet/tools $PATH
  end
end

# Set up GEM_HOME
if not test -d ~/.gem/bin
  mkdir -p ~/.gem/bin
end
set -x GEM_HOME ~/.gem
set -x PATH ~/.gem/bin $PATH

if not test -d ~/bin
  mkdir ~/bin
end
set -x PATH ~/bin $PATH

# Set up GoLang
if not test -d ~/go/bin
  mkdir -p ~/go.bin
end

set -x PATH ~/go/bin $PATH

if type -q go
  set -x GOPATH (go env GOPATH)
end

# Kube stuff
if test -d /usr/local/kubebuilder/bin
  set -x PATH /usr/local/kubebuilder/bin $PATH
end

# gcloud autocomplete
if test -f ~/google-cloud-sdk/path.fish.inc
  source ~/google-cloud-sdk/path.fish.inc
end

status --is-interactive; and fzf_key_bindings

# Python set up
if type -q pyenv
  source (pyenv init - | psub)
end
if type -q vf && ! test -f ~/.config/fish/conf.d/virtualfish-loader.fish
  vf install
end

fish_ssh_agent
if type -q register-python-argcomplete
  register-python-argcomplete --shell fish az|grep -v _ARGCOMPLETE_DFS| .
else if type -q register-python-argcomplete3
  register-python-argcomplete3 --shell fish az|grep -v _ARGCOMPLETE_DFS| .
end

string match -q "$TERM_PROGRAM" "vscode"
  and . (code --locate-shell-integration-path fish)


