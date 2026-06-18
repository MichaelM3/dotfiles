---
name: generate-commits
description: >-
  Split local changes into intentional commits. Use when the user invokes
  generate-commits, asks to make commits, or asks for commit grouping. Default
  is to create commits automatically unless the user asks for a plan/dry run.
---

# Generate Commits

Use local `git` as source of truth. This skill groups and creates commits; it
does not open PRs (**pr-summary**).

## Default Behavior

When explicitly invoked, inspect, stage logical slices, and commit them. Do not
stop at a plan unless the user says `plan`, `dry run`, `suggest`, `message
only`, or `no commit`.

## Safety

1. Run from repo root.
2. Inspect first: `git status --short`, `git status -sb`, `git log --oneline -20`.
3. Preserve unrelated/user changes. Commit only changes that belong together.
4. Before rewriting/splitting history, verify upstream state (`@{u}` if present).
   If already pushed/shared, stop and ask.

## Message Format

Use Conventional Commits, imperative subject, no trailing period:

```bash
git commit -m "type(scope): subject under 72 chars"
```

Add a body for breaking changes, migrations, security, or non-obvious tradeoffs.

## Workflows

### Clean tree + reviewable local commits

Do nothing. Reply that commits are already reviewable.

### Clean tree + one oversized local commit

Split only when it improves review/bisect/changelog value and the commit is not
pushed/shared.

1. `git reset --soft HEAD~1`.
2. Restage logical slices with `git add` or `git add -p`.
3. Commit in dependency order: build/config/migrations -> fix/feat -> tests/docs.

### Uncommitted work

Group by intent, not file count:

| Intent | Type |
| --- | --- |
| User-visible behavior/API | `feat` |
| Bug | `fix` |
| Docs only | `docs` |
| Tests only | `test` |
| No-behavior code move | `refactor` |
| Tooling/CI/deps | `chore` / `ci` / `build` |

Stage one slice, commit, repeat until intended work is committed. Use
`git status --short` between commits.

## Anti-Patterns

- One commit per file when concerns are not separate.
- Mixed docs/tooling/product changes when independent.
- Silent reset, rebase, or force-push on shared history.
- Subject-only messages for risky or non-obvious changes.

## After Commits

Use **pr-summary** when the user wants a PR draft/open/update.
