# My dotfiles

## Install

on Wsl:

```sh
cd ~
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init tkvw
chezmoi apply
```

## Requirements

- age
- nu shell
- autojump
- starship

### Windows

- nushell (winget install nushell)
- scoop

```
iex "&{$(irm 'https://get.chezmoi.io/ps1')} -b '~/.local/bin' -- init --apply tkvw"
```

# Wsl installation

```
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply tkvw
```

### Linux

- homebrew

## Todo

[ ] - Auto install required software
[ ] - Make compatible with widows

# SSH

Use the ssh agent of bitwarden and disable the ssh agent of windows.
