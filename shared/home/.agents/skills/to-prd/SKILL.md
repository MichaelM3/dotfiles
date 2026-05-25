---
name: to-prd
description: Turn current conversation and repo context into a PRD, then publish it through the configured project issue tracker. Use when the user asks to create a PRD, convert discussion into a product spec, or publish a PRD for agent-ready work.
---

# To PRD

Synthesize what is already known. Do not interview by default; record open
questions instead of inventing answers.

## Project Docs And Tracker

Follow `/home/unbalanced/.agents/instructions/project-artifacts.md`.
Read `.agents/issue-tracker.md`, `.agents/triage-labels.md`,
`.agents/domain.md`, glossaries, and ADRs first. If tracker config is missing,
run or recommend `setup-matt-pocock-skills`.

## Process

1. Explore the repo enough to describe the current system accurately.
2. Use project glossary vocabulary and respect ADRs.
3. Identify major modules likely to change. Look for deep module opportunities:
   small interface, substantial implementation, good test surface.
4. Write the PRD.
5. Publish through the configured tracker:
   - GitHub/GitLab: create an issue.
   - Local markdown: write `.agents/issues/<feature-slug>/PRD.md`.
   - Other: follow `.agents/issue-tracker.md`.
6. Apply or record the `ready-for-agent` role unless the PRD contains blocking
   open questions.

## PRD Template

```markdown
# <Feature>

## Problem Statement
## Solution
## User Stories
## Implementation Decisions
## Testing Decisions
## Out Of Scope
## Open Questions
## Further Notes
```

Implementation decisions should name modules, interfaces, contracts, schemas,
and interactions. Avoid file paths and code snippets unless a prototype snippet
encodes a decision more precisely than prose.
