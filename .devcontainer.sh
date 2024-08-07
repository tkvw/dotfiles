#!/bin/sh

set -e # -e: exit on error

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="$HOME/.local/bin"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsSL get.chezmoi.io)" -- -b "$bin_dir" init --promptDefaults --promptChoice target=docker --apply
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- get.chezmoi.io)" -- -b "$bin_dir" init --promptDefaults --promptChoice target=docker --apply
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
fi

# Installer script for chezmoi in vscode
# sh -c "$(curl -fsLS get.chezmoi.io)" -- init --promptDefaults --promptChoice target=docker --apply