#!/bin/sh

# Installer script for chezmoi in vscode
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --promptDefaults --promptChoice target=docker --apply