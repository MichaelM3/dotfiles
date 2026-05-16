---
name: architecture
description: Review and improve codebase architecture with deep modules, domain language, and testability. Use when the user asks to improve architecture, refactor, reduce coupling, find deeper modules, or understand how a subsystem should be shaped.
---

# Architecture

## Vocabulary

- Module: any unit with interface and implementation.
- Interface: everything callers must know: types, invariants, errors, ordering, config, side effects.
- Implementation: code behind the interface.
- Deep module: small interface, substantial behavior, high leverage.
- Shallow module: interface nearly as complex as implementation.
- Seam: place behavior can vary without editing callers.
- Adapter: concrete implementation behind a seam.
- Deletion test: if deleting a module removes complexity, it was likely pass-through; if complexity spreads to callers, it was earning its keep.

## Review Process

1. Read `AGENTS.md`, `CONTEXT.md`, `CONTEXT-MAP.md`, and `docs/adr/` if present.
2. Map current modules, callers, data flow, and tests before recommending changes.
3. Find candidates where complexity leaks across many files, tests are forced through awkward setup, or domain language is missing from interfaces.
4. Present candidates with files, problem, proposed shape, expected leverage, locality gain, and test improvement.
5. Respect ADRs. If a candidate contradicts one, say why the current friction may justify revisiting it.
6. Implement only after the user approves the direction or the task explicitly asks for implementation.

## Good Refactors

- Collapse repeated caller logic behind a named domain operation.
- Move parsing, validation, retries, caching, or policy decisions behind one interface.
- Replace speculative seams with real ones only when at least two adapters or callers justify them.
- Prefer boring names from the project glossary over pattern names.

## Guardrails

- Do not perform broad style rewrites.
- Do not introduce abstractions that merely rename existing code.
- Keep tests at the new interface, proving the behavior callers rely on.
