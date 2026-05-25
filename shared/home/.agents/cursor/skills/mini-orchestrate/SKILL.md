---
name: mini-orchestrate
disable-model-invocation: true
description: >-
  Post-grill implementation orchestration via user-level subagents (orchestrator, coder, reviewer,
  documentor, verifier, investigator). Use when the user confirms ready to implement after
  grill-with-docs, or invokes /mini-orchestrate with an approved plan. Delegates via /name or
  "Use the … subagent" per Cursor docs — not Task(subagent_type). Do not use during grilling.
---

# Mini-orchestrate

Lightweight local orchestration after **grill-with-docs** (or any decision-complete plan). One
**mini-orchestrator** subagent decomposes work and delegates to role agents. Workers do not talk to
each other; they return structured handoffs to the orchestrator.

Inspired by [orchestrate](https://github.com/cursor/plugins/tree/main/orchestrate) and
[cursor-team-kit](https://github.com/cursor/plugins/tree/main/cursor-team-kit) — IDE subagents, not
cloud SDK.

**Delegation (required reading):** [references/delegation.md](references/delegation.md) — matches
[Cursor subagents docs](https://cursor.com/docs/subagents).

## When to load

| Situation | Load? |
| --- | --- |
| User still in grill-with-docs Q&A | No |
| User says ready / proceed / implement after grill output | **Yes** |
| User types `/mini-orchestrate` with an approved plan | **Yes** |
| Ad-hoc small fix, no plan | No — implement inline |

## Handoff from grill-with-docs

When the user confirms ready and this skill is installed (`~/.cursor/skills/mini-orchestrate/` +
`~/.cursor/agents/mini-orchestrator.md`):

1. Load this skill.
2. Do **not** implement in the main thread.
3. Delegate to orchestrator (see **Start orchestrator** below).
4. Stay dispatcher until orchestrator final report.

Teammates without this install → **verify-plan** → **tdd** / **agent-handoff** (grill-with-docs
fallback). Do not mention mini-orchestrate unless they ask.

## Start orchestrator

**Primary** — slash or natural language with plan bundle ([spawning.md](references/spawning.md)):

```text
/mini-orchestrator
<plan bundle>
```

```text
Use the mini-orchestrator subagent to implement this decision-complete plan: …
```

**If no isolated subagent run starts** — fallback ladder in [delegation.md](references/delegation.md):
emulate orchestrator from `~/.cursor/agents/mini-orchestrator.md`, delegate `/mini-*` workers, never
skip handoff schemas.

**Never** use `Task(subagent_type: "mini-orchestrator")` — not supported for custom agents.

## Role roster

User agents: `~/.cursor/agents/`. Invoke with `/name` or “Use the … subagent”.

| Role | Agent | Model | readonly | Purpose |
| --- | --- | --- | --- | --- |
| **Orchestrator** | `mini-orchestrator` | `composer-2.5` | no | Plan, delegate workers, aggregate |
| **Coder** | `mini-coder` | `composer-2.5-fast` | no | One scoped implementation slice |
| **Reviewer** | `mini-reviewer` | `composer-2.5` | yes | Static senior review |
| **Documentor** | `mini-documentor` | `composer-2.5-fast` | no | Docs, ADR, OpenAPI, changelog |
| **Verifier** | `mini-verifier` | `composer-2.5-fast` | yes | Run tests/repro |
| **Investigator** | `mini-investigator` | `composer-2.5-fast` | yes | Read-only scout |

Model IDs must match your Cursor model picker; Cursor may override per plan/admin (docs FAQ).

### Reviewer vs Verifier

- **Reviewer** — diff/code; bugs, spec drift, design consistency.
- **Verifier** — commands/tests; VERIFIED / NOT VERIFIED / INCONCLUSIVE.

Use both after non-trivial coder work.

## Core principles

1. **Orchestrator delegates; does not implement.** `/mini-coder` for code changes.
2. **Workers isolated.** One scoped task per delegation.
3. **Structured handoffs** — [handoffs.md](references/handoffs.md); final message only.
4. **Vertical slices** over layer-only edits.
5. **Feedback loop** — must-fix / NOT VERIFIED → `/mini-coder` fix → re-review/re-verify.
6. **Documentor last** (or parallel when doc scope is clear).

## Dispatcher workflow

```
User confirms ready
  → load mini-orchestrate
  → /mini-orchestrator + plan bundle
  → orchestrator: /mini-investigator? → /mini-coder → /mini-verifier → /mini-reviewer → /mini-documentor
  → orchestrator final report → user
```

Main thread does not code unless fallback ladder exhausted and user approves inline work.

## Parallelism

- Multiple `/mini-investigator` delegations in one message when angles differ.
- Multiple `/mini-coder` only when slices are independent (no shared files).
- Do not parallelize review/verify before coder handoff completes.

## Stop conditions

- Acceptance criteria verified or waived in writing.
- No reviewer `must-fix` (or fixed and re-reviewed).
- Documentor handoff complete or N/A with reason.
- Out-of-scope → follow-ups list, no silent expansion.

OnSched repos: **ship-checklist** awareness; documentor owns most doc steps.

## Additional resources

- [references/delegation.md](references/delegation.md) — invoke + fallback ladder
- [references/spawning.md](references/spawning.md) — plan bundle + worker briefs
- [references/handoffs.md](references/handoffs.md) — output schemas
