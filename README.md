# dotfiles

## On a new machine

- Install [Homebrew](https://brew.sh)
  - Let Homebrew install itself into `~/.zprofile` first. Remove it later.
- Install `chezmoi` and `zsh` with `brew install chezmoi zsh`

## Init dotfiles

chezmoi init --apply git@github.com:soundmonster/dotfiles.git
cd $(chezmoi source-path)
chezmoi status
chezmoi apply

## Wezterm

Unquarantine with:
```
xattr -rd com.apple.quarantine /Applications/WezTerm.app
```
