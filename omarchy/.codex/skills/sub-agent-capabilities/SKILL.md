---
name: sub-agent-capabilities
description: >-
  Global sub-agent policy for Codex. Use for complex, parallelizable, or
  multi-phase work when delegation is explicitly allowed by the active runtime.
---

# Sub-Agent Capabilities

Goal: use right model for right work while keeping delegation bounded.

## Global Limits

- Main thread: GPT-5.5, `reasoning_effort = "medium"`.
- Maximum agent tree depth: `max_depth = 1`.
- Maximum concurrent agent threads: `max_threads = 3`.
- Custom agents live in `/home/unbalanced/.codex/agents/`.
- Prefer 1-3 sub-agents.
- Never delegate destructive git, secrets, credentials, deploys, or external
  mutation decisions without explicit user approval.

## Roles

- `planner`: GPT-5.5, medium reasoning, read-only planning/spec/risk checks.
- `developer`: GPT-5.3-Codex, medium reasoning, scoped code edits/tests.
- `researcher`: GPT-5.4-mini, medium reasoning, read-only search/evidence.

## Delegation Rules

- Delegate only independent side work that can run while main thread progresses.
- Keep urgent blockers local.
- Use disjoint write scopes for concurrent developer agents.
- Parent orchestrator audits sub-agent output before final answer.

## Output

Sub-agent results stay compact: paths, findings, changed files, verification,
blockers.
