# Main guidelines for working with Claude

- Communicate in Dutch with the user, but use English for code and commit messages and examples (cli or otherwise).
- Keep your responses concise and to the point, avoid unnecessary explanations or details, unless asked for.

# Environment

- Platform: Windows 11
- You use git bash as your shell, keep in mind proper escaping for git bash when running commands.
- My preferred editor is nvim (LazyVim)
- I use pnpm package manager instead of npm or yarn.

## Powershell

- If you execute powershell commands, always use pwsh.exe instead of powershell.exe.
- When running one of commands using -C always use single quotes to avoid issues with escaping in git bash.
- Prefer to write the command to a file first and run pwsh.exe using the -File option instead of using -C, this way you can avoid escaping issues and have a more readable command.

## Nushell

- When running one of commands using nu.exe, always use single quotes to avoid issues with escaping in git bash.
- Prefer to write the command to a file first and run nu.exe using the file parameter instead of using -c, this way you can avoid escaping issues and have a more readable command.

# Code Conventions

- Write all code, comments, and documentation in English.
- Add XML doc comments (`/// <summary>`) to every public class, method, property, and parameter. Focus on intent, behavior, and expected usage — not implementation details.
- Add inline comments only when the code does something non-obvious — explain _why_, not _what_.
- Keep methods short and single-purpose. If a method needs a long explanation, it should probably be split.
- No unnecessary comments or docstrings, only add comments if they provide value and help to understand the code better.

# Git Commit & Release Strategy

This project has two modes. I will tell you when we switch. Assume **pre-release** until told otherwise.
Commit messages should be in English, concise and descriptive of the changes made. Avoid vague messages like "fix" or "update", instead use messages that clearly describe the purpose of the commit, such as "Add new feature X" or "Fix bug Y".

## Pre-release mode

- Use conventional commits (`feat`, `fix`, `refactor`, etc.), imperative mood, max 72 chars.
- Commit small, focused changes. One logical change per commit.
- Do not create changesets, bump versions, or update changelogs.
- Commit after completing a task, asking for confirmation on the message.

## Released mode

- Same commit format as pre-release.
- After every user-facing or API-affecting change, run `npx changeset` before committing.
- Write changeset descriptions from the user's perspective, not the developer's.
- Choose the appropriate semver bump: `patch` for fixes, `minor` for features, `major` for breaking changes. When unsure, prefer `patch`.
- Do not create changesets for internal refactors, tests, CI changes, or bugs introduced in the same unreleased cycle.
- Never run `npx changeset version` or `npx changeset publish` — that happens in CI, unless asked for
