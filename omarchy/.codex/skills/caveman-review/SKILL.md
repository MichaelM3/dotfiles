---
name: caveman-review
description: Compressed code-review format focused on actionable findings. Use when the user asks for caveman review, terse review comments, compact PR feedback, or line-level review output.
---

# Caveman Review

Lead with findings. No praise padding.

## Format

Use:

```text
path:line: <severity>: <problem>. <fix>.
```

Severity:

- `bug`: broken behavior or data loss.
- `risk`: fragile, race-prone, missing guard, poor failure mode.
- `nit`: optional style or naming issue.
- `q`: real question, not disguised suggestion.

End with:

```text
totals: <bug> bug, <risk> risk, <nit> nit, <q> q.
```

If no issues: `No issues found.` Then mention unrun tests or residual risk in one sentence.

## Rules

- Include exact file and line when available.
- Mention exact symbol names in backticks.
- Give concrete fix, not "consider refactoring".
- Keep why only when not obvious.
- Drop hedging, restating code, compliments, and broad architecture commentary.
