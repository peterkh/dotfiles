# ~/.bash_profile: executed by bash(1) for login shells.
# fish is the main shell; this is a minimal fallback.

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:$HOME/.docker/bin"
# End of Docker Desktop section.

for d in ~/.local/bin ~/go/bin ~/bin; do
  [ -d "$d" ] && PATH="$d:$PATH"
done
export PATH

export EDITOR=nvim
export AWS_REGION=ap-southeast-2

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
