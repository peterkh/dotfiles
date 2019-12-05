set -x PATH ~/Library/Python/2.7/bin/ $PATH
set -x PATH ~/Library/Python/3.7/bin/ $PATH

set -x GEM_HOME ~/.gem
set -x PATH ~/.gem/bin $PATH

set -x PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set -x PATH /usr/local/opt/grep/libexec/gnubin $PATH

set -x GOPATH (go env GOPATH)

source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
