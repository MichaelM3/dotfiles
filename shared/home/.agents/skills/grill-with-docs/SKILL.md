---
name: grill-with-docs
description: Stress-test a plan against project domain language and recorded decisions, updating PROJECT_ROOT/.agents glossaries and ADRs as terms or durable decisions crystallize. Use when the user wants to be grilled on a code plan while preserving domain vocabulary or architecture decisions.
---

# Grill With Docs

Interview relentlessly until the plan is precise. Ask one question at a time
and provide the recommended answer with each question. If code can answer the
question, inspect code instead of asking.

## Project Docs

Follow `/home/unbalanced/.agents/instructions/project-artifacts.md`.
Resolve `PROJECT_ROOT` first. Read existing `.agents` docs and legacy root
context docs before writing. New artifacts go only under `PROJECT_ROOT/.agents`.

## During The Session

- Challenge glossary conflicts immediately.
- Sharpen fuzzy or overloaded terms into one canonical term.
- Stress-test relationships with concrete scenarios and edge cases.
- Cross-check claims against code and surface contradictions.
- Update `.agents/CONTEXT.md` or the relevant context glossary inline when a
  term is resolved. Do not batch glossary updates.
- Offer ADRs only for decisions that are hard to reverse, surprising without
  context, and real trade-offs.

## Glossary Rules

Use `references/CONTEXT-FORMAT.md`.

- Glossaries define domain language only, not implementation plans.
- Create `.agents/CONTEXT.md` only when the first term is resolved.
- Create `.agents/CONTEXT-MAP.md` only after the user confirms multi-context
  layout.
- In multi-context repos, write context docs under
  `.agents/contexts/<context-slug>/`.

## ADR Rules

Use `references/ADR-FORMAT.md`.

- Create `.agents/adr/` or `.agents/contexts/<context-slug>/adr/` only when
  the first ADR is accepted.
- Number ADRs by scanning existing accepted ADRs in the target ADR directory.
- Keep ADRs short; record decision and why, not ceremony.
