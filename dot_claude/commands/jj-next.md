Describe the current jj working copy change and start a new empty change.

Steps:

1. Run `jj diff --stat` and `jj log --limit 3` to understand the current changes
2. Propose a conventional commit message (imperative mood, max 72 chars)
3. Ask the user for confirmation or adjustments
4. Run `jj describe -m "<confirmed message>"` to set the description
5. Run `jj new` to create a new empty working copy change
