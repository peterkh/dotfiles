#!/bin/bash
set -e
cd "$(dirname "$0")"

FISHER_VERSION=4.4.8

install_macos() {
  # A fresh Homebrew install isn't on PATH yet, so look in its standard locations
  for brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [ -x "$brew" ]; then
      eval "$("$brew" shellenv)"
      break
    fi
  done

  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found, install it first: https://brew.sh" >&2
    exit 1
  fi
  brew bundle --file Brewfile
}

install_ubuntu() {
  local sudo=""
  [ "$(id -u)" -ne 0 ] && sudo=sudo

  # Ubuntu's own fish package lags well behind, so use the fish-shell PPA
  $sudo apt-get update
  $sudo apt-get install -y software-properties-common curl
  $sudo add-apt-repository -y ppa:fish-shell/release-4
  $sudo apt-get install -y fish stow git

  # fisher isn't packaged for apt. Keep it in fish's per-user vendor dirs rather
  # than ~/.config/fish, otherwise `fisher update` removes it as it isn't listed
  # in fish_plugins.
  local base=https://raw.githubusercontent.com/jorgebucaran/fisher/$FISHER_VERSION
  mkdir -p ~/.local/share/fish/vendor_functions.d ~/.local/share/fish/vendor_completions.d
  curl -fsSL "$base/functions/fisher.fish" -o ~/.local/share/fish/vendor_functions.d/fisher.fish
  curl -fsSL "$base/completions/fisher.fish" -o ~/.local/share/fish/vendor_completions.d/fisher.fish
}

# Ask once per machine for the git identity, which .gitconfig reads from
# ~/.gitconfig.local (and ~/.gitconfig.personal for github.com/peterkh repos)
setup_git_identity() {
  if git config --file ~/.gitconfig.local user.email >/dev/null 2>&1; then
    return
  fi
  if [ ! -t 0 ]; then
    echo "Skipping git identity (not a terminal), see .gitconfig to set it" >&2
    return
  fi

  local name email personal
  read -r -p "Git name [Peter Hall]: " name || true
  read -r -p "Git email for this machine: " email || true
  if [ -z "$email" ]; then
    echo "No email given, skipping git identity" >&2
    return
  fi
  git config --file ~/.gitconfig.local user.name "${name:-Peter Hall}"
  git config --file ~/.gitconfig.local user.email "$email"

  read -r -p "Personal email for github.com/peterkh repos [same]: " personal || true
  if [ -n "$personal" ] && [ "$personal" != "$email" ]; then
    git config --file ~/.gitconfig.personal user.email "$personal"
  fi
}

case "$(uname -s)" in
Darwin)
  install_macos
  ;;
Linux)
  if grep -q '^ID=ubuntu' /etc/os-release 2>/dev/null; then
    install_ubuntu
  elif ! command -v stow >/dev/null 2>&1; then
    echo "Install stow (and fish) with your package manager first" >&2
    exit 1
  fi
  ;;
esac

# Stow won't replace real files, e.g. the default ~/.bashrc on a new Ubuntu
# user, so move those aside first
find . -path ./.git -prune -o -type f \
  ! -name install.sh ! -name Brewfile ! -name README.md ! -name .gitignore -print |
while read -r f; do
  target=~/${f#./}
  if [ -f "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "$target.pre-dotfiles"
    echo "Moved existing $target to $target.pre-dotfiles"
  fi
done

# --no-folding links individual files rather than whole directories, so files
# that tools write at runtime (e.g. fish_variables) stay out of the repo
stow -t ~ -v --no-folding --ignore='install.sh' --ignore='Brewfile' .

setup_git_identity

if command -v fish >/dev/null 2>&1; then
  fish -c 'fisher update'
fi
