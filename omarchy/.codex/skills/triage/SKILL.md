---
name: triage
description: Triage bugs, feature requests, and issue queues for agent-ready execution. Use when the user asks to triage issues, prepare work for an agent, label incoming work, reproduce reported bugs, or decide whether an issue is ready.
---

# Triage

## States

- `needs-triage`: not yet evaluated.
- `needs-info`: blocked on reporter/user detail.
- `ready-for-agent`: enough context, acceptance criteria, and verification for an AFK agent.
- `human-needed`: product, design, access, or judgment still required.
- `not-planned`: duplicate, out of scope, invalid, or not worth doing now.

Use project-specific labels if `AGENTS.md` defines them.

## Workflow

1. Read the full issue, comments, labels, linked PRs, and previous triage notes.
2. Inspect relevant code and docs. For bugs, attempt reproduction before asking product questions.
3. Summarize current understanding, likely area, and missing facts.
4. Recommend one state with reasoning.
5. If ready, rewrite the issue so another agent can execute without chat history.

## Ready-for-Agent Checklist

- Expected behavior and current behavior are clear.
- Repro steps or implementation goal are concrete.
- Relevant files or search terms are included.
- Acceptance criteria are testable.
- Verification commands are listed.
- Dependencies and out-of-scope items are explicit.

## Needs-Info Template

```markdown
## Triage notes

What we know:
- ...

What we still need:
- ...
```
