---
name: sub-agent-capabilities
description: Bounded delegation policy. Use when work is complex, parallelizable, or multi-phase and the user/session explicitly allows subagents.
---

# Sub-Agent Capabilities

Goal: improve outcomes without losing main-thread control or context budget.

## Limits

- Parent/main thread owns plan, integration, judgment, and final answer.
- Keep delegation depth at 1.
- Prefer 1-3 concurrent children.
- Delegate only bounded work with clear inputs, outputs, and ownership.
- Never delegate destructive git, secrets, credentials, deploys, or external mutation decisions without explicit user approval.

## Good Delegation Targets

- Read-only code/docs discovery.
- Focused implementation in known files or disjoint write scopes.
- Independent verification or repro attempts.
- Static review of an existing diff.
- Docs/ADR/release-note updates with clear scope.

## Avoid

- Vague “look around” tasks.
- Broad refactors without ownership boundaries.
- Parallel writers touching overlapping files.
- Child agents spawning more children.

## Output Contract

Require compact results: paths, findings, changed files, commands run, verdict, blockers.
