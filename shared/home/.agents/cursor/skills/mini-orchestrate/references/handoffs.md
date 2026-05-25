# Mini-orchestrate handoffs

Workers return **one final message** in these shapes. The orchestrator parses these; the main thread
may show a condensed summary to the user.

## Coder handoff

```markdown
## Status
success | partial | blocked

## What I did
- <summary; per file if useful>

## Files touched
- `path` — <one line>

## Verification (self)
<command run → outcome, or "not run — verifier required">

## Deviations
- <spec delta or "none">

## Blockers
- <blocker or "none">

## Suggested follow-ups
- <optional next tasks for orchestrator>
```

## Investigator handoff

```markdown
## Status
complete

## Findings
- `path:line` — `symbol` — <note>

## Recommended edit sites
1. `path:line` — <why>

## Gaps
- <what could not be found in repo>
```

## Verifier handoff

Aligns with cursor-team-kit **verify-this** verdicts.

```markdown
## Verdict
VERIFIED | NOT VERIFIED | INCONCLUSIVE

## Claim tested
<falsifiable statement from acceptance criteria>

## Execution
- `<command>` → <outcome>

## Evidence
<metrics, test counts, repro steps observed>

## Notes
<env blockers, flakiness, or "none">
```

## Reviewer handoff

```markdown
## Summary
<one paragraph>

## Findings
### must-fix
- `path:line` — <issue>. <fix hint>

### should-fix
- `path:line` — <issue>

### nit
- `path:line` — <issue>

## Spec adherence
met | partial | not met — <brief>

## Totals
N must-fix, N should-fix, N nit
```

If no issues: `## Findings` → `No issues.` and totals `0 must-fix, 0 should-fix, 0 nit`.

## Documentor handoff

```markdown
## Status
complete | partial | blocked

## Updates made
- `path` — <what changed>

## Deferred (needs product input)
- <item or "none">

## Release / parity notes
<OpenAPI, changeset, changelog, glossary — done or flagged>

## ADR
<path if written, or "none needed" with reason>
```

## Orchestrator final report (to main thread / user)

```markdown
## Mini-orchestrate complete

### Goal
<one line>

### Shipped
- <bullet list of outcomes>

### Verification
<verifier verdicts summary>

### Review
<reviewer summary; must-fix status>

### Docs
<documentor summary>

### Follow-ups
- <out of scope or next phase>

### Waivers
- <explicit user waivers honored>
```
