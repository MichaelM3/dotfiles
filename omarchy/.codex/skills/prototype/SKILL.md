---
name: prototype
description: Build throwaway prototypes to answer uncertain product, UI, state-machine, or architecture questions. Use when the user asks to prototype, mock up, try variants, sanity-check logic, or make something playable before committing to production design.
---

# Prototype

## Choose Branch

- Logic/state uncertainty: build a tiny CLI, script, story, or isolated route that makes states and transitions visible.
- UI uncertainty: build multiple distinct variants reachable from one route, query param, tab, or local toggle.
- API/data uncertainty: use fixtures or scratch storage with clear prototype naming.

## Rules

1. Mark prototype files clearly with `prototype`, `scratch`, or the repo's established convention.
2. Put the prototype near the real area it informs, unless the repo has a scratch area.
3. Provide one command or URL to run it.
4. Keep state visible after each action.
5. Avoid durable persistence unless persistence is the question being tested.
6. Skip production polish, broad error handling, and abstractions.
7. When done, delete it or fold the validated decision into production code.

## Final Report

State what the prototype proved, what it did not prove, how to run it, and what should happen next.
