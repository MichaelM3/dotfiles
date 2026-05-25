---
name: architecture
description: Review and improve codebase architecture with deep modules, domain language, and testability. Use when the user asks to improve architecture, refactor, reduce coupling, find deeper modules, or understand how a subsystem should be shaped.
---

# Architecture

## Project Context

Follow `/home/unbalanced/.agents/instructions/project-artifacts.md`. Read
domain docs, ADRs, and legacy compatibility docs before recommending changes.
Use project domain vocabulary plus the architecture vocabulary below.

Reference details:

- `references/LANGUAGE.md`
- `references/DEEPENING.md`
- `references/INTERFACE-DESIGN.md`
- `references/HTML-REPORT.md`

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

1. Read project instructions, `.agents` domain docs, ADRs, and legacy compatibility docs.
2. Map current modules, callers, data flow, and tests before recommending changes.
3. Find candidates where complexity leaks across many files, tests are forced through awkward setup, or domain language is missing from interfaces.
4. Present candidates with files, problem, proposed shape, expected leverage, locality gain, and test improvement.
5. Respect ADRs. If a candidate contradicts one, say why the current friction may justify revisiting it.
6. Implement only after the user approves the direction or the task explicitly asks for implementation.

## Optional HTML Report

When the user asks for a review artifact, write a self-contained HTML report to
the OS temp directory, never the repo: `$TMPDIR` or `/tmp` on Unix, `%TEMP%` on
Windows. Use `architecture-review-<timestamp>.html`, then give the absolute
path. Use Tailwind/Mermaid CDNs only if the user is comfortable with browser
network access; otherwise keep the report static.

## Good Refactors

- Collapse repeated caller logic behind a named domain operation.
- Move parsing, validation, retries, caching, or policy decisions behind one interface.
- Replace speculative seams with real ones only when at least two adapters or callers justify them.
- Prefer boring names from the project glossary over pattern names.

## Guardrails

- Do not perform broad style rewrites.
- Do not introduce abstractions that merely rename existing code.
- Keep tests at the new interface, proving the behavior callers rely on.
- If exploring alternative interfaces with subagents, do so only when the
  active harness supports subagents and policy/user permission allows it.
