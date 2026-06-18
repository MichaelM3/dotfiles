---
name: grill-with-docs
description: Stress-test a plan against project domain language and recorded decisions, updating PROJECT_ROOT/.agents glossaries and ADRs as terms or durable decisions crystallize. Use when the user wants to be grilled on a code plan while preserving domain vocabulary or architecture decisions.
---

# Grill With Docs

Run `grilling` and `domain-modeling` together: interview until the plan is
precise while updating project domain language and ADRs inline.

Load and follow:

- `/home/unbalanced/.agents/skills/grilling/SKILL.md`
- `/home/unbalanced/.agents/skills/domain-modeling/SKILL.md`

## Project Docs

Follow `/home/unbalanced/.agents/instructions/project-artifacts.md`.
Resolve `PROJECT_ROOT` first. Read existing `.agents` docs and legacy root
context docs before writing. New artifacts go only under `PROJECT_ROOT/.agents`,
never under `/home/unbalanced/.agents`.

## During The Session

- Update `.agents/CONTEXT.md` or the relevant context glossary inline when a
  term is resolved. Do not batch glossary updates.
- Offer ADRs only for decisions that are hard to reverse, surprising without
  context, and real trade-offs.

## Closing The Session

- Do not auto-implement after the last grilling question.
- End with the final spec or plan from the session.
- Split the plan into phases when that improves delegation or sequencing.
- Ask whether to implement, start phase 1, or hand off to subagents.

## Glossary Rules

Use `/home/unbalanced/.agents/skills/domain-modeling/references/CONTEXT-FORMAT.md`.

- Glossaries define domain language only, not implementation plans.
- Create `.agents/CONTEXT.md` only when the first term is resolved.
- Create `.agents/CONTEXT-MAP.md` only after the user confirms multi-context
  layout.
- In multi-context repos, write context docs under
  `.agents/contexts/<context-slug>/`.

## ADR Rules

Use `/home/unbalanced/.agents/skills/domain-modeling/references/ADR-FORMAT.md`.

- Create `.agents/adr/` or `.agents/contexts/<context-slug>/adr/` only when
  the first ADR is accepted.
- Number ADRs by scanning existing accepted ADRs in the target ADR directory.
- Keep ADRs short; record decision and why, not ceremony.
