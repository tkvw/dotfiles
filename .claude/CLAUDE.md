# Chezmoi Dotfiles Repository

Cross-platform dotfiles managed with [chezmoi](https://www.chezmoi.io/) targeting Windows, WSL, and Docker environments.

## Repository Structure

| Directory/File | Purpose |
|---|---|
| `.chezmoi.toml.tmpl` | Chezmoi config template (target selection, git identity, age encryption) |
| `.chezmoidata/` | Data files — `packages.yaml` holds package versions |
| `.chezmoiexternals_/` | External archive/file downloads (tools like nushell, starship, sops, mkcert) |
| `.chezmoiscripts/` | Lifecycle scripts executed during `chezmoi apply` |
| `.chezmoitemplates/` | Reusable Go templates (age install helpers, key setup) |
| `dot_config/`, `dot_local/` | XDG config and local directories |
| `private_dot_ssh/` | SSH configuration (private prefix = restrictive permissions) |
| `AppData/` | Windows-specific application data (symlinked configs) |
| `encrypted_*` | Age-encrypted secret files |

## Chezmoi Naming Conventions

- `dot_` → `.` (e.g., `dot_gitconfig` → `.gitconfig`)
- `private_` → file gets restrictive permissions (0600)
- `encrypted_` → file is age-encrypted in the repo
- `symlink_` → creates a symlink instead of a regular file
- `.tmpl` suffix → file is processed as a Go template
- `run_once_before_XX_name` → script runs once before apply, `XX` controls ordering

Prefixes can be combined: `encrypted_private_dot_secrets.yaml.age`

## Template Variables

Available in `.tmpl` files via chezmoi's template data:

- `.target` — one of `windows`, `wsl`, `docker`
- `.git.home.email`, `.git.home.signingkey` — personal git identity
- `.git.work.email`, `.git.work.signingkey` — work git identity
- `.packages.<name>.version` — package versions from `.chezmoidata/packages.yaml`
- `.age.key` — age private key (from env `CHEZMOI_AGE_KEY` or prompt)
- `.chezmoi.os`, `.chezmoi.arch` — standard chezmoi variables

## Guidelines

- **Never commit encrypted file contents in plaintext** — use `chezmoi encrypt` or edit with `chezmoi edit`
- **Test platform conditionals** for all targets (windows/wsl/docker) when modifying `.tmpl` files
- **Package versions** go in `.chezmoidata/packages.yaml`, not hardcoded in templates or externals
- **Script naming**: use `run_once_before_XX_name` with ordering numbers (00, 10, 20...)
- **New unmanaged files** in the repo root must be added to `.chezmoiignore`
- **Externals** in `.chezmoiexternals_/` define tool downloads with version templating from packages data
