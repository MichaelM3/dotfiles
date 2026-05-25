---
name: prototype
description: Build throwaway prototypes to answer uncertain product, UI, state-machine, or architecture questions. Use when the user asks to prototype, mock up, try variants, sanity-check logic, or make something playable before committing to production design.
---

# Prototype

A prototype is throwaway code that answers one question. The question decides
the shape.

## Choose Branch

- Logic/state uncertainty: read `references/LOGIC.md` and build a tiny
  interactive terminal app or script that makes states and transitions visible.
- UI uncertainty: read `references/UI.md` and build multiple structurally
  distinct variants reachable from one existing route, query param, tab, or
  local toggle.
- API/data uncertainty: use fixtures or scratch storage with clear prototype naming.

## Rules

1. Mark prototype files clearly with `prototype`, `scratch`, or the repo's established convention.
2. Put the prototype near the real area it informs, unless the repo has a scratch area.
3. Provide one command or URL to run it.
4. Keep state visible after each action.
5. Avoid durable persistence unless persistence is the question being tested.
6. Skip production polish, broad error handling, and abstractions.
7. When done, delete it or fold the validated decision into production code.
8. Capture the durable answer in a commit message, ADR, issue, or local
   `NOTES.md` before deleting or folding in the prototype.

## Final Report

State what the prototype proved, what it did not prove, how to run it, and what should happen next.
