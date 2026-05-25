---
name: to-issues
description: Break a plan, spec, or PRD into tracker-published tracer-bullet issues using AFK/HITL vertical slices. Use when the user asks to create implementation issues, turn a PRD into tickets, or break work into agent-ready slices.
---

# To Issues

Create independently grabbable vertical slices. Each slice should deliver a
narrow end-to-end behavior, not one horizontal layer.

## Project Docs And Tracker

Follow `/home/unbalanced/.agents/instructions/project-artifacts.md`.
Read `.agents/issue-tracker.md`, `.agents/triage-labels.md`,
`.agents/domain.md`, glossaries, and ADRs. If tracker config is missing, run or
recommend `setup-matt-pocock-skills`.

## Process

1. Gather source material from conversation, linked issue, PRD path, or tracker.
2. Explore adjacent code if needed so slices match the current architecture.
3. Draft tracer-bullet slices. Mark each `AFK` or `HITL`.
4. Ask the user to approve granularity, dependencies, and AFK/HITL split.
5. Publish approved issues in dependency order:
   - GitHub/GitLab: create issues and reference blockers by issue ID.
   - Local markdown: write `.agents/issues/<feature-slug>/issues/NN-slug.md`.
   - Other: follow `.agents/issue-tracker.md`.
6. Apply or record `ready-for-agent` only for AFK slices without open decisions.

## Slice Rules

- Each slice is demoable or verifiable on its own.
- Prefer many thin slices over a few thick ones.
- HITL means human judgment, access, design review, or product decision remains.
- AFK means an agent can execute from the issue without chat history.

## Issue Template

```markdown
# <Slice Title>

Status: ready-for-agent
Type: AFK | HITL

## Parent
## What To Build
## Acceptance Criteria
## Blocked By
## Context
## Tests
## Out Of Scope
```
