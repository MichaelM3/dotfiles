# Spawning mini-orchestrate subagents

Invocation: [delegation.md](delegation.md) (`/name` or “Use the … subagent”). **Not**
`Task(subagent_type: "mini-*")`.

## Plan bundle (orchestrator input)

Paste after `/mini-orchestrator` or “Use the mini-orchestrator subagent to …”:

```markdown
## Goal
<one line>

## Decision-complete plan
<paste grill output: terms, acceptance scenarios, ADR candidates, release impact>

## Constraints
- Repo path: <absolute workspace path>
- Layers / paths in scope: <list>
- Out of scope: <list>
- Explicit waivers: <list or none>

## Project skills (load when touching this repo)
<OnSched: v3, tdd, ship-checklist, rdme-docs, etc. — or "none">

## User confirmation
User confirmed ready to implement on <date or "this session">.
```

## Delegate workers (orchestrator or main thread)

```text
/mini-coder
<worker brief below>
```

Parallel scouts:

```text
/mini-investigator <angle A>
/mini-investigator <angle B>
```

## Worker brief template

Self-contained — subagents start with clean context (docs).

```markdown
## Overall goal (context only)
<from plan>

## Your scoped task
<single concrete outcome>

## Paths
- May modify: <glob or paths>
- Do not modify: <glob or paths>
- Read for context: <optional>

## Acceptance criteria
- [ ] <observable criterion>
- [ ] <test or command that proves it>

## Spec / design notes
<decisions from grill; file:line anchors when known>

## Dependencies
<upstream handoff summaries or "none">

## Handoff
Reply with the structure from handoffs.md for your role. Final message only.
```

## When to delegate each role

| Trigger | Delegate |
| --- | --- |
| Unknown edit sites | `/mini-investigator` (1–3 parallel messages) |
| Scoped implementation ready | `/mini-coder` |
| Coder success; need execution proof | `/mini-verifier` |
| Code changed; static review | `/mini-reviewer` |
| Public API / docs / ADR parity | `/mini-documentor` |

## Slice sizing

- **Good coder task:** one vertical slice, ≤3 files, clear acceptance.
- **Split when:** cross-cutting refactor, 4+ files, unknown architecture.
- **Investigator first** when orchestrator cannot name exact paths.

## Re-delegate after feedback

```markdown
## Fix task (from review/verify)
Original task: <id/summary>
Findings to address:
1. <reviewer must-fix or verifier failure>
...
Do not regress: <list>
Re-handoff when done.
```

Send as `/mini-coder` with fix brief.
