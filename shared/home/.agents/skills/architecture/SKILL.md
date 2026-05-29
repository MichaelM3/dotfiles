---
name: architecture
description: Review and improve codebase architecture with deep modules, domain language, and testability. Use when the user asks to improve architecture, refactor, reduce coupling, find deeper modules, or understand how a subsystem should be shaped.
---

# Architecture

## Context

Follow `/home/unbalanced/.agents/instructions/project-artifacts.md`. Read relevant domain docs, ADRs, and compatibility docs before recommending changes.

Use references only when needed:

- `references/LANGUAGE.md`
- `references/DEEPENING.md`
- `references/INTERFACE-DESIGN.md`
- `references/HTML-REPORT.md`

## Vocabulary

- Module: unit with interface and implementation.
- Interface: everything callers must know: types, invariants, errors, ordering, config, side effects.
- Implementation: code behind the interface.
- Deep module: small interface, substantial hidden behavior.
- Shallow module: interface nearly as complex as implementation.
- Seam: place behavior can vary without editing callers.
- Adapter: concrete implementation behind a seam.

## Review Process

1. Map modules, callers, data flow, and tests.
2. Find where complexity leaks across files, test setup is awkward, or domain language is missing.
3. Present candidates with files, problem, proposed shape, leverage, locality gain, and test impact.
4. Respect ADRs; flag any contradiction explicitly.
5. Implement only after user approval unless implementation was requested.

## Good Refactors

- Collapse repeated caller logic behind a named domain operation.
- Hide parsing, validation, retries, caching, and policy behind one interface.
- Add seams only when real variation justifies them.
- Name concepts from project vocabulary, not patterns.

## Guardrails

- No broad style rewrites.
- No abstractions that merely rename code.
- Keep tests at the interface callers use.
- For review artifacts, write optional HTML reports to temp, not the repo; see `references/HTML-REPORT.md`.
