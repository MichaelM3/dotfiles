---
name: codebase-design
description: Shared vocabulary for deep modules, interfaces, seams, adapters, and testable design. Use when designing or improving module shape, test seams, or architecture.
---

# Codebase Design

Design deep modules: substantial behavior behind a small interface at a clean
seam, tested through that interface.

## Vocabulary

- Module: anything with an interface and implementation.
- Interface: everything callers must know: types, invariants, ordering,
  errors, config, side effects, and performance expectations.
- Implementation: code hidden behind the interface.
- Depth: leverage at the interface. Deep modules expose small interfaces with
  substantial behavior behind them.
- Seam: place behavior can vary without editing callers.
- Adapter: concrete implementation satisfying an interface at a seam.
- Leverage: capability callers get per unit of interface they learn.
- Locality: change, bugs, knowledge, and verification concentrated in one
  module.

Use those terms exactly. Avoid substituting component, service, unit, API,
signature, boundary, layer, or wrapper when these terms are meant.

## Principles

- Depth is a property of the interface, not implementation line count.
- Deletion test: if deleting a module removes complexity, it was pass-through;
  if complexity spreads to callers, it was earning its keep.
- The interface is the test surface. Callers and tests cross the same seam.
- One adapter is a hypothetical seam; two adapters justify a real seam.
- Prefer accepting dependencies over creating them internally.
- Prefer returning results over forcing side effects when the domain allows.

## Use In Design

1. Name the candidate module and its callers.
2. State the proposed interface, including invariants and error modes.
3. Classify dependencies; read `references/DEEPENING.md` when deepening a
   cluster with I/O or cross-process dependencies.
4. Compare alternatives by depth, locality, seam placement, and test surface.
5. Recommend one shape; do not add a seam unless real variation justifies it.

For parallel interface exploration, use `references/DESIGN-IT-TWICE.md` only
when the user/session explicitly allows subagents.
