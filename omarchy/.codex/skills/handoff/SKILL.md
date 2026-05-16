---
name: handoff
description: Produce compact handoff notes for another Codex agent or future session. Use when the user asks for a handoff, context compacting, session summary, or agent transfer.
---

# Handoff

Write a handoff that lets a fresh agent continue without replaying the whole conversation.

## Process

1. Create a temporary markdown file with `mktemp -t handoff-XXXXXX.md` when the user wants a saved artifact.
2. Read any existing artifact before overwriting or appending.
3. Do not duplicate PRDs, plans, ADRs, commits, or diffs. Link paths/URLs instead.
4. Include only durable facts, decisions, current state, and next actions.
5. Suggest relevant skills for the next agent.

## Template

```markdown
# Handoff

## Goal
## Current State
## Decisions Made
## Files Changed
## Verification
## Open Questions
## Next Steps
## Suggested Skills
```

Keep it terse. Prefer paths, commands, and status over narrative.
