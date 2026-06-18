---
name: resolving-merge-conflicts
description: Resolve an in-progress git merge or rebase conflict. Use when git reports conflicts or the user asks to resolve merge/rebase conflicts.
---

# Resolving Merge Conflicts

Resolve conflicts by preserving intent. Never use destructive git commands or
abort unless the user explicitly asks.

## Workflow

1. Inspect state:
   - `git status --short`
   - merge/rebase state files when present
   - conflicting files
   - relevant commit history
2. Find primary sources for each side:
   - commit messages
   - PR or issue refs if available
   - neighboring tests and docs
3. Resolve each hunk:
   - preserve both intents where compatible
   - choose the side matching the merge goal when incompatible
   - do not invent unrelated behavior
4. Run project checks likely affected by the conflict.
5. Stage only resolved conflict files.
6. Continue the merge/rebase only when that is the expected current operation.

## Report

Name each conflicted file, what intent was preserved, checks run, and any risk
that needs human review.
