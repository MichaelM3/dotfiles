# Out-Of-Scope Knowledge Base

Rejected enhancement requests can be recorded under
`PROJECT_ROOT/.agents/out-of-scope/`.

## Purpose

- Preserve why a feature was rejected.
- Deduplicate future similar requests.

## File Shape

One file per concept:

```markdown
# Dark Mode

This project does not support user-facing theming.

## Why This Is Out Of Scope

Durable reason tied to scope, architecture, or strategy.

## Prior Requests

- #42 - Add dark mode
```

Use short kebab-case filenames such as `dark-mode.md`.

## During Triage

Read `.agents/out-of-scope/*.md` early. Match by concept similarity, not exact
keywords. If a new request matches, surface the prior decision and ask whether
the maintainer still agrees.

Write/update an out-of-scope file only when an enhancement is rejected as
`wontfix`. Do not use it for bugs.
