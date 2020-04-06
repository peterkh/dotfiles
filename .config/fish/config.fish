switch (uname -s)
case Darwin
  set -x PATH ~/Library/Python/2.7/bin/ $PATH
  set -x PATH ~/Library/Python/3.7/bin/ $PATH
  set -x PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
  set -x PATH /usr/local/opt/grep/libexec/gnubin $PATH
  set -x PATH /usr/local/opt/postgresql@11/bin $PATH
end

set -x GEM_HOME ~/.gem
set -x PATH ~/.gem/bin $PATH


if type -q go
  set -x GOPATH (go env GOPATH)
end

if test -f ~/google-cloud-sdk/path.fish.inc
  source ~/google-cloud-sdk/path.fish.inc
end
fzf_key_bindings
