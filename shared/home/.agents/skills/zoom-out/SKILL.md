---
name: zoom-out
description: Map unfamiliar code from a higher level, including modules, callers, data flow, and domain vocabulary. Use when the user asks to zoom out, wants broader code context, or needs to understand how a section fits the system.
---

# Zoom Out

Give the higher-level map before diving deeper.

## Project Docs

Follow `/home/unbalanced/.agents/instructions/project-artifacts.md`.
Read `.agents/domain.md`, glossaries, ADRs, and legacy compatibility docs before
mapping the code. Use glossary vocabulary in the explanation.

## Output

Cover only relevant scope:

- Domain concepts involved.
- Modules and their interfaces.
- Main callers and callees.
- Data/state flow.
- Important seams and adapters.
- Tests or commands that exercise the area.
- ADRs or constraints that explain surprising shape.
- What to inspect next, in order.
