---
name: pr-summary
description: >-
  Draft, create, or update a pull request for the current branch. Use when the
  user invokes pr-summary, asks for a PR description, or asks to open/update a
  PR. Default when explicitly invoked is create/update unless the user asks for
  draft text only.
---

# PR Summary

Draft a reviewer-useful PR title/body for the current local branch, then create
or update the GitHub PR. If the user asks for `draft`, `summary only`, `body
only`, `changelog`, or `no PR`, return text only and do not touch remote PR
metadata.

## Preconditions

Run from repo root.

1. `git status --short` must be clean. If dirty: stop and ask the user to run
   **generate-commits** or commit intended work first.
2. Current branch must not be the base branch.
3. Current branch must be pushed and not ahead of upstream. If not pushed, push
   when the user explicitly asked to open/update/create PR; otherwise ask.
4. Fetch/verify the chosen base before comparing: `git fetch origin <BASE>` when
   network and remotes are available.

## Base Selection

- `pr-summary <branch>` -> base `<branch>`.
- No branch named -> infer from upstream PR metadata, repo default, or common
  branches (`dev`, `main`) in that order.
- Never retarget an existing PR unless the user explicitly asks.

## Gather

- `git branch --show-current` -> head branch.
- `git log origin/<BASE>..HEAD --oneline` -> themes.
- `git diff origin/<BASE>...HEAD --stat` -> areas touched.
- Existing PR: prefer GitHub MCP/app if available; fallback `gh pr list --head
  <branch> --state open`.

## Draft Format

Title: imperative, reviewer-focused, ideally <=72 chars.

```markdown
## Summary

[2-4 sentences: problem/goal, user-visible change, why it matters.]

## Areas touched

- [domain/layer, not every file]

## How to test

- [commands or manual checks + expected result]

## Notes

[Optional: risk, follow-up, migrations, flags]
```

Avoid diff dumps, exhaustive path lists, commit-message paste, and AI filler.

## Create Or Update

Prefer GitHub MCP/app when available; fallback `gh`.

- Existing open PR for current head: update title/body.
- No open PR: create with `base=<BASE>`, `head=<current branch>`, drafted
  title/body.
- If create says PR already exists: detect again, then update.

Use real MCP/`gh` responses for URL/number; do not fabricate.

## Output

Return PR URL when created/updated, whether created/updated/drafted, base used
(or actual existing base), and one-line reviewer focus.
