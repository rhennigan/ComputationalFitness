---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git checkout:*)
description: Create a git commit
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Your task

Based on the above changes, do the following:

- If on the main branch, create a new branch for the changes using the naming convention `feature/your-name-here`, `bugfix/your-name-here`, etc. NEVER commit directly to the main branch.
- Once on an appropriate branch, commit the changes with an appropriate commit message.