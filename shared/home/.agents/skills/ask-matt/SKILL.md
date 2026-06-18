---
name: ask-matt
description: Router over Matt Pocock-style user-invoked skills. Use when the user asks which skill or flow fits their situation.
disable-model-invocation: true
---

# Ask Matt

Pick the smallest flow that fits the user's situation. This is a router, not a
worker skill.

## Main Flow: Idea To Ship

Use when the user has an idea and wants it built in a repo.

1. `grill-with-docs`: sharpen the idea by interview while preserving project
   language and ADRs under `PROJECT_ROOT/.agents`.
2. If a question needs runnable evidence, branch through `handoff` ->
   `prototype` -> `handoff`, then return to the original idea thread.
3. Multi-session build: `to-prd` -> `to-issues`; each issue starts a fresh
   session and uses `implement`.
4. Single-session build: use `implement` in the current context.

Keep grilling, PRD, and issue breakdown in one unbroken context window when
possible. Use `handoff` when a fresh session is needed with durable context.

## On-Ramps

- Raw bug reports or feature requests: `triage`.
- Hard bug or regression in the current repo: `diagnosing-bugs`.
- Existing implementation plan that needs checking: `verify-plan`.

## Codebase Health

- `improve-codebase-architecture`: user-facing architecture review flow.
- `architecture`: local compatibility name for architecture and refactoring.
- `codebase-design`: shared deep-module vocabulary used by other skills.

## Standalone

- `grill-me`: interview without writing project docs.
- `teach`: stateful teaching workspace in the current directory.
- `writing-great-skills`: reference for writing and editing skills.
- `resolving-merge-conflicts`: in-progress merge or rebase conflict.

## Setup

Run `setup-matt-pocock-skills` once per repo before tracker or domain-doc
flows. It writes repo-local config under `PROJECT_ROOT/.agents`, never under
the shared home at `/home/unbalanced/.agents`.
