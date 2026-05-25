---
name: codex-mini-orchestrate
description: >-
  Codex-native mini orchestration for decision-complete implementation plans.
  Use when the user asks for Codex mini-orchestrate, confirms ready to implement
  after planning, or wants coordinated planner/coder/researcher/reviewer/
  verifier/documentor sub-agent work. Do not use for small single-file fixes.
---

# Codex Mini-orchestrate

Use this skill to run a bounded Codex orchestration loop from the main thread.
The main thread is the Orchestrator: GPT-5.5 with high reasoning. It owns task
decomposition, delegation, integration, and final judgment.

Codex agents live in `/home/unbalanced/.agents/codex/agents/`.

## When To Load

| Situation | Load? |
| --- | --- |
| User confirms ready after a decision-complete plan | Yes |
| User asks for `codex-mini-orchestrate` or Codex mini-orchestrate | Yes |
| Multi-file implementation with separable investigation, coding, review, docs | Yes |
| Ad-hoc narrow fix | No, implement inline |
| User is still deciding requirements | No, use planning / verify-plan first |

## Role Roster

| Role | Agent | Model | Sandbox | Purpose |
| --- | --- | --- | --- | --- |
| Orchestrator | main thread | `gpt-5.5`, high | current | Plan, delegate, audit, integrate |
| Planner | `planner` | `gpt-5.5`, high | read-only | ExecPlan, risk, task slicing |
| Coder | `coder` | `gpt-5.3-codex`, xhigh | workspace-write | Scoped implementation |
| Researcher | `researcher` | `gpt-5.4-mini`, medium | read-only | Fast code/docs discovery |
| Reviewer | `reviewer` | `gpt-5.5`, medium | read-only | Static senior review |
| Verifier | `verifier` | `gpt-5.4-mini`, medium | read-only | Tests, repro, acceptance proof |
| Documentor | `documentor` | `gpt-5.4-mini`, medium | workspace-write | Docs, ADR, changelog, API notes |

Use `coder` for implementation. `gpt-5.3-codex` with xhigh reasoning is preferred for bounded code
edits in this harness; switch to main-thread `gpt-5.5` only for unusually
ambiguous or architecture-heavy code decisions.

## Orchestrator Workflow

1. Restate goal, constraints, acceptance criteria, and out-of-scope items.
2. Load `sub-agent-capabilities`; keep `max_depth = 1` and `max_threads <= 3`.
3. If plan quality is uncertain, delegate to `planner` for an ExecPlan audit.
4. If edit sites are unknown, delegate 1-3 independent searches to `researcher`.
5. Delegate one vertical implementation slice at a time to `coder`.
6. After code changes, delegate execution proof to `verifier`.
7. Delegate static review to `reviewer`.
8. Loop must-fix or NOT VERIFIED findings back to `coder`.
9. Delegate documentation to `documentor` when public API, ADR, changelog, docs,
   or release notes are affected.
10. Main thread reads diffs and verification before final response.

## Delegation Prompts

Planner:

```text
Use the planner agent. Stay read-only. Audit this plan against the repo and
return an ExecPlan with risks, scoped coder tasks, and verification:
<plan bundle>
```

Researcher:

```text
Use the researcher agent. Stay read-only. Find evidence for:
<question>
Return path:line findings, likely edit sites, and gaps only.
```

Coder:

```text
Use the coder agent. You are not alone in the codebase; do not revert
others' edits.

Overall goal: <goal>
Scoped task: <one vertical slice>
May modify: <paths/globs>
Do not modify: <paths/globs>
Acceptance criteria:
- <criterion>
Verification to run: <commands>

Final handoff: status, files touched, verification, deviations, blockers.
```

Verifier:

```text
Use the verifier agent. Stay read-only on source. Prove or disprove:
<acceptance criteria>
Changed paths: <paths>
Commands/repro to try: <commands>
Return VERIFIED, NOT VERIFIED, or INCONCLUSIVE with evidence.
```

Reviewer:

```text
Use the reviewer agent. Stay read-only. Review this implementation against the
goal and acceptance criteria:
<goal/spec>
Changed paths: <paths>
Return must-fix, should-fix, nit findings with path:line evidence.
```

Documentor:

```text
Use the documentor agent.
Change summary: <what shipped>
Doc surfaces to inspect: <README/docs/API/ADR/changelog/etc.>
May modify: <paths/globs>
Return updates made, deferred items, and release/API notes.
```

## Handoff Shapes

Coder:

```markdown
## Status
success | partial | blocked

## Files touched
- `path` - summary

## Verification
`command` -> outcome, or not run with reason

## Deviations
none | list

## Blockers
none | list
```

Verifier:

```markdown
## Verdict
VERIFIED | NOT VERIFIED | INCONCLUSIVE

## Claim tested
<falsifiable claim>

## Evidence
- `command` -> outcome

## Notes
none | blockers/flakes
```

Reviewer:

```markdown
## Findings
### must-fix
- `path:line` - issue. fix hint.

### should-fix
- `path:line` - issue.

### nit
- `path:line` - issue.

## Totals
N must-fix, N should-fix, N nit
```

No issues: `No issues.` with zero totals.

Documentor:

```markdown
## Status
complete | partial | blocked

## Updates made
- `path` - summary

## Deferred
none | list

## Release / API notes
none | summary
```

## Stop Conditions

- Acceptance criteria verified or explicitly waived.
- No reviewer must-fix remains.
- Documentation done or documented as not applicable.
- Follow-ups are out-of-scope, not hidden incomplete work.

Final user response: shipped outcome, changed files, verification, review/docs
status, and remaining follow-ups.
