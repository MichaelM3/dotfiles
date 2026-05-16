---
name: planning
description: Convert conversation, specs, or rough plans into PRDs, implementation plans, and issue-sized vertical slices. Use when the user asks for a PRD, issues, tickets, implementation plan, feature breakdown, or wants to be grilled on a design.
---

# Planning

## Context Pass

Before writing durable plans, inspect the repo enough to avoid generic advice:

- Read `AGENTS.md`, `README*`, package manifests, project docs, `CONTEXT.md`, `CONTEXT-MAP.md`, and ADRs if present.
- Search for adjacent features and test patterns.
- Use project vocabulary, not invented product names.

## PRD Shape

Use this structure unless the repo has its own template:

```markdown
# <Feature>

## Problem
## Goals
## Non-goals
## User Stories
## Current System
## Proposed Solution
## Implementation Notes
## Testing Plan
## Risks and Open Questions
```

Keep implementation notes concrete enough for an agent, but do not over-specify internals that should be discovered during coding.

## Issue Slicing

Break work into independently grabbable vertical slices:

- Each issue should deliver observable behavior or infrastructure needed by the next slice.
- Mark dependencies explicitly.
- Include acceptance criteria, likely files, tests to run, and human decisions needed.
- Prefer 1-2 day chunks for human work and smaller AFK-agent chunks.

Issue template:

```markdown
## What to build
## Acceptance criteria
## Context
## Suggested approach
## Tests
## Blocked by
```

## Grilling Mode

When the user asks to be grilled:

1. Ask one question at a time.
2. Provide the recommended answer with the question.
3. If code can answer it, inspect code instead of asking.
4. Walk dependencies in order: user outcome, domain model, state, failure modes, persistence, permissions, rollout, tests.
