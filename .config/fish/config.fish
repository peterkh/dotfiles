switch (uname -s)
case Darwin
  set -x PATH ~/Library/Python/2.7/bin/ $PATH
  set -x PATH ~/Library/Python/3.7/bin/ $PATH
  set -x PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
  set -x PATH /usr/local/opt/grep/libexec/gnubin $PATH
  set -x PATH /usr/local/opt/postgresql@11/bin $PATH
  set -x PATH /usr/local/opt/gnu-which/libexec/gnubin $PATH
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
if type -q go
  set -x GOPATH (go env GOPATH)
end

# gcloud autocomplete
if test -f ~/google-cloud-sdk/path.fish.inc
  source ~/google-cloud-sdk/path.fish.inc
end

fzf_key_bindings

# Python set up
if type -q pyenv
  source (pyenv init - | psub)
end
if type -q vf && ! test -f ~/.config/fish/conf.d/virtualfish-loader.fish
  vf install
end

fish_ssh_agent
