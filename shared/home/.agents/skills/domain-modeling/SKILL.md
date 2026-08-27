---
name: domain-modeling
description: Build and sharpen a project's domain model. Use when discussing codebase terminology, writing or editing a glossary or context map, or recording or editing an ADR.
---

# Domain Modeling

Actively sharpen the project's domain model while designing. This skill changes
the model; merely reading existing vocabulary does not invoke it.

## Project Artifacts

Follow `$HOME/.agents/instructions/project-artifacts.md`. Resolve
`PROJECT_ROOT` first. Read existing `.agents` domain docs and legacy root
context docs before writing. New artifacts go only under
`PROJECT_ROOT/.agents`, never under `$HOME/.agents`.

Single-context layout:

```text
.agents/
  CONTEXT.md
  adr/0001-example.md
```

Multi-context layout:

```text
.agents/
  CONTEXT-MAP.md
  adr/
  contexts/<context-slug>/
    CONTEXT.md
    adr/
```

Create files lazily. Create `CONTEXT.md` when the first term resolves,
`CONTEXT-MAP.md` only after the user confirms multiple contexts, and an ADR
directory only when the first ADR is accepted.

## During The Session

- Challenge terms that conflict with the existing glossary immediately.
- Sharpen vague or overloaded words into precise canonical terms.
- Stress-test relationships with concrete edge-case scenarios.
- Cross-check claims against code and surface contradictions.
- Update the relevant glossary inline when a term resolves; do not batch.

Use `CONTEXT-FORMAT.md`. A context glossary contains domain language only, not
implementation details, specs, decisions, or scratch notes.

## ADRs

Offer an ADR only when the decision is hard to reverse, surprising without
context, and the result of a real trade-off. If any condition is absent, skip
it. Use `ADR-FORMAT.md` and number against accepted ADRs in the target project
ADR directory.
