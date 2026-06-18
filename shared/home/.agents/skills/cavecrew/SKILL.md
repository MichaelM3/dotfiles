---
name: cavecrew
description: Token-efficient subagent handoffs. Use when the user explicitly asks to delegate, spawn subagents, use cavecrew, save context with agents, or coordinate compact investigator/builder/reviewer outputs.
---

# Cavecrew

Use only when subagents are allowed. Parent owns plan, integration, and final verification.

Goal: child outputs stay path-first and compact.

## Roles

- Investigator: find definitions, callers, tests, errors, or relevant files.
- Builder: make a bounded edit in known files with clear ownership.
- Reviewer: inspect diff/touched files for actionable findings.

## Delegate When

- Search can run beside local work.
- Edit scope is independent and disjoint.
- Review can happen after implementation while parent verifies.

Keep blocking, coupled, or high-judgment work in parent.

## Output Shapes

Investigator:

```text
findings:
- path:line - symbol - note
gaps: ...
```

Builder:

```text
changed:
- path - summary
verified: command -> result
blocked: none|reason
```

Reviewer:

```text
path:line: severity: problem. fix.
totals: ...
```

## Guardrails

- No broad refactors as child tasks.
- No overlapping writers.
- No generic reviewer feedback; findings only.
- Parent reviews output before relying on it.
