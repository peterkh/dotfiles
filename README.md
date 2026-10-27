# dotfiles

Config for fish, Neovim, tmux, git and a minimal bash fallback, linked into `~` with [GNU Stow](https://www.gnu.org/software/stow/).

## Install

On macOS, install [Homebrew](https://brew.sh) first, then:

```sh
git clone git@github.com:peterkh/dotfiles.git ~/git/dotfiles
~/git/dotfiles/install.sh
```

On Ubuntu, run the same two commands; no Homebrew needed. Other Linux distros need `stow` and `fish` installed first.

`install.sh` is safe to re-run. It:

1. installs packages:
   - macOS: everything in `Brewfile`
   - Ubuntu: `fish` from the [fish-shell PPA](https://launchpad.net/~fish-shell/+archive/ubuntu/release-4) and `stow` from apt (uses `sudo`), plus fisher into `~/.local/share/fish/vendor_functions.d`
2. moves any existing real files it would replace (e.g. Ubuntu's default `~/.bashrc`) to `<name>.pre-dotfiles`
3. symlinks every file into `~` with `stow --no-folding`
4. installs the fish plugins listed in `.config/fish/fish_plugins` with fisher

### Git identity

The first run asks for a name and email for the machine, which are kept out of the repo:

- `~/.gitconfig.local` holds the machine's default identity, e.g. the work email on a work laptop.
- `~/.gitconfig.personal` holds a personal email, used for any repo with a `github.com/peterkh` remote. Leave it blank on a personal laptop.

`user.useConfigOnly` is on, so git refuses to commit until an email is set rather than inventing one from the hostname. To set or change them by hand:

```sh
git config --file ~/.gitconfig.local user.name "Peter Hall"
git config --file ~/.gitconfig.local user.email "you@work.example"
git config --file ~/.gitconfig.personal user.email "you@personal.example"
```

To make fish the login shell:

```sh
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
```

## Notes

- Stow links individual files, not directories, so anything a tool writes at runtime (`fish_variables`, fisher plugins, Docker's completions) lands in `~/.config` and stays out of the repo.
- Add a fish plugin with `fisher install <repo>`, which records it in `fish_plugins`; commit that file.
- Machine-specific git settings go in `~/.gitconfig.local`, which `.gitconfig` includes.
