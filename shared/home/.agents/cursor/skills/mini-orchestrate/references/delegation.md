# Delegating mini-orchestrate subagents

Per [Cursor subagents docs](https://cursor.com/docs/subagents). Custom agents live in
`~/.cursor/agents/*.md`. Cursor routes delegation — **do not** pass custom names to
`Task(subagent_type: …)` (not documented; runtime rejects unknown enum values).

## Primary invocation (use this)

### Slash syntax

```text
/mini-orchestrator
<plan bundle from spawning.md>
```

Workers (orchestrator sends these, or main thread for single slices):

```text
/mini-coder <worker brief>
/mini-investigator <scout question>
/mini-verifier <acceptance criteria + paths changed>
/mini-reviewer <scope + spec notes>
/mini-documentor <doc delta brief>
```

### Natural language (equivalent)

```text
Use the mini-orchestrator subagent to implement this plan: …
Use the mini-coder subagent to …
Have the mini-verifier subagent prove …
```

### Parallel work

Send **multiple delegations in one message** when slices are independent (docs: parallel subagents):

```text
Use the mini-investigator subagent to locate route handlers for X.
Use the mini-investigator subagent to locate tests for X.
```

## What not to do

```text
# WRONG — custom subagent_type is not a public API
Task(subagent_type: "mini-orchestrator", …)
```

Built-in subagents in docs: `explore`, `bash`, `browser`. Your mini-* agents are **custom** — invoke
by **name** via `/name` or explicit prose.

## Fallback ladder

Use the next step only when the previous step did not produce an isolated subagent run.

| Step | When | Action |
| --- | --- | --- |
| **1** | Always try first | `/mini-orchestrator` + plan bundle; main thread stays dispatcher |
| **2** | No subagent spawn / immediate inline coding | Read `~/.cursor/agents/mini-orchestrator.md`; **emulate orchestrator** — delegate workers via `/mini-*`, still no main-thread implementation |
| **3** | Workers won't spawn | Run slices sequentially: `/mini-coder` → `/mini-verifier` → `/mini-reviewer` → `/mini-documentor` with briefs from spawning.md |
| **4** | User has no mini-orchestrate | Project fallback: **verify-plan** → **tdd** / **agent-handoff** (see grill-with-docs) |

After step 2–3, tell the user which path ran so expectations stay clear.

## Nested orchestration (orchestrator → workers)

Since Cursor 2.5, subagents may spawn child subagents. Orchestrator should:

1. Delegate with `/mini-coder` (or natural language), **not** Task enum hacks.
2. Keep depth ≤2 (orchestrator → worker) when possible — nested model routing can be flaky.
3. Read worker **final message only** (handoffs.md); resume with agent ID if Cursor returns one.

## Model frontmatter

Each `~/.cursor/agents/mini-*.md` sets `model`. Values must match your **model picker** IDs.
Cursor may override per plan, Max Mode, or admin policy (see docs FAQ).

## Verify install

```text
~/.cursor/skills/mini-orchestrate/SKILL.md
~/.cursor/agents/mini-orchestrator.md
~/.cursor/agents/mini-coder.md
… (other roles)
```

Smoke test: `/mini-investigator List files under api/services matching customerBookingLimits`
