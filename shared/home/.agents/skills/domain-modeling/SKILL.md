---
name: domain-modeling
description: Build and sharpen project domain language and ADRs. Use when terminology, ubiquitous language, context maps, or durable architectural decisions need to be recorded.
---

# Domain Modeling

Actively maintain the project's domain model while planning or designing. This
skill changes project docs; it is not needed for merely reading existing docs.

## Project Artifacts

Follow `/home/unbalanced/.agents/instructions/project-artifacts.md`.
Resolve `PROJECT_ROOT` first. New artifacts go only under
`PROJECT_ROOT/.agents`, never the shared home at `/home/unbalanced/.agents`.

Read existing project docs before writing:

- `PROJECT_ROOT/.agents/CONTEXT.md`
- `PROJECT_ROOT/.agents/CONTEXT-MAP.md`
- `PROJECT_ROOT/.agents/contexts/*/CONTEXT.md`
- `PROJECT_ROOT/.agents/adr/`
- legacy root `CONTEXT.md`, `CONTEXT-MAP.md`, and `docs/adr/`

## Session Discipline

- Challenge glossary conflicts immediately.
- Sharpen fuzzy or overloaded terms into one canonical term.
- Stress-test relationships with concrete scenarios and edge cases.
- Cross-check user claims against code when code can answer.
- Update the relevant glossary inline when a term is resolved. Do not batch.
- Keep glossaries domain-only: no implementation plans, specs, or scratchpad.

## Glossary Rules

Use `references/CONTEXT-FORMAT.md`.

- Single context: write `PROJECT_ROOT/.agents/CONTEXT.md`.
- Multi-context: write
  `PROJECT_ROOT/.agents/contexts/<context-slug>/CONTEXT.md`.
- Create `.agents/CONTEXT.md` only when the first term is resolved.
- Create `.agents/CONTEXT-MAP.md` only after the user confirms multi-context
  layout.

## ADR Rules

Use `references/ADR-FORMAT.md`.

Offer an ADR only when the decision is hard to reverse, surprising without
context, and the result of a real trade-off. Create ADR directories lazily.
