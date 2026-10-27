# The following lines were added by Docker Desktop to add commands to your PATH.
fish_add_path -gPa ~/.docker/bin
# End of Docker Desktop section.

# fish_add_path -gPm: edit $PATH directly (not universal fish_user_paths),
# moving existing entries rather than duplicating them in nested shells
switch (uname -s)
case Darwin
  set HOME_BREW_PREFIX (/opt/homebrew/bin/brew --prefix)
  fish_add_path -gPm /usr/local/bin
  fish_add_path -gPm $HOME_BREW_PREFIX/opt/coreutils/libexec/gnubin
  fish_add_path -gPm $HOME_BREW_PREFIX/opt/grep/libexec/gnubin
  fish_add_path -gPm $HOME_BREW_PREFIX/opt/gnu-which/libexec/gnubin
  fish_add_path -gPm $HOME_BREW_PREFIX/opt/gnu-tar/libexec/gnubin
  fish_add_path -gPm $HOME_BREW_PREFIX/opt/gnu-sed/libexec/gnubin
  fish_add_path -gPm $HOME_BREW_PREFIX/bin
  fish_add_path -gPm $HOME_BREW_PREFIX/sbin
  fish_add_path -gPm "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  fish_add_path -gPm /usr/local/share/dotnet
  fish_add_path -gPm ~/.dotnet/tools
  fish_add_path -gPm ~/.local/bin
case Linux
  fish_add_path -gPm ~/.local/bin
  if test -d ~/.pyenv
    set -x PYENV_ROOT $HOME/.pyenv
    fish_add_path -gPm $PYENV_ROOT/bin
  end
  fish_add_path -gPm /usr/local/go/bin
  fish_add_path -gPm ~/.dotnet/tools
end

# Set up GEM_HOME
if not test -d ~/.gem/bin
  mkdir -p ~/.gem/bin
end
set -x GEM_HOME ~/.gem
fish_add_path -gPm ~/.gem/bin

if not test -d ~/bin
  mkdir ~/bin
end
fish_add_path -gPm ~/bin

# Set up GoLang
if not test -d ~/go/bin
  mkdir -p ~/go/bin
end

fish_add_path -gPm ~/go/bin

if type -q go
  set -x GOPATH (go env GOPATH)
end

# gcloud autocomplete
if test -f ~/google-cloud-sdk/path.fish.inc
  source ~/google-cloud-sdk/path.fish.inc
end

# Python set up
if type -q pyenv
  source (pyenv init - | psub)
end
if type -q vf && ! test -f ~/.config/fish/conf.d/virtualfish-loader.fish
  vf install
end

# macOS's launchd ssh-agent handles keys (with Keychain), so only start our own on Linux
if test (uname -s) = Linux
  fish_ssh_agent
end
if type -q register-python-argcomplete
  register-python-argcomplete --shell fish az|grep -v _ARGCOMPLETE_DFS| .
else if type -q register-python-argcomplete3
  register-python-argcomplete3 --shell fish az|grep -v _ARGCOMPLETE_DFS| .
end

string match -q "$TERM_PROGRAM" "vscode"
  and . (code --locate-shell-integration-path fish)


