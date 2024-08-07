#!/bin/sh

set -e # -e: exit on error
  
sh -c "$(curl -fsSL get.chezmoi.io/lb)" -- init --promptDefaults --promptChoice target=docker --apply
