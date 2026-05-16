---
name: cavecrew
description: Token-efficient delegation and agent-handoff patterns for Codex subagents. Use when the user explicitly asks to delegate, spawn subagents, use cavecrew, save context with agents, or coordinate investigator/builder/reviewer handoffs.
---

# Cavecrew

Use only when subagents are allowed by the user or current instructions. Keep
main thread responsible for plan, integration, and final verification.

Goal: subagent results stay compact enough to preserve main-thread context.
Prefer path-first facts over prose.

## Roles

- Investigator: locate definitions, callers, tests, errors, or relevant files. Output path-first facts.
- Builder: make a bounded edit in known files. Best for 1-2 files with clear ownership.
- Reviewer: inspect a diff or touched files for bugs and missing verification.

## When To Delegate

- Use investigator for broad search that can run beside local work.
- Use builder for independent edits with disjoint write scope.
- Use reviewer after implementation while main thread continues verification.
- Keep blocking, tightly coupled, or high-judgment work in main thread.
- Use normal prose when the user needs explanation, tradeoffs, or architecture commentary.

## Output Contracts

Ask investigators for:

```text
Findings:
- path:line - `symbol` - note
totals: ...
```

Ask builders for:

```text
changed:
- path - summary
verified: command/result or not run
blocked: none|reason
```

Ask reviewers for:

```text
path:line: severity: problem. fix.
totals: ...
```

## Chaining

- Locate -> fix -> verify: investigator returns sites, builder edits selected files, reviewer audits diff.
- Parallel scout: spawn separate investigators for definitions, callers, and tests.
- Single-shot edit: skip investigator only when exact files are already known.

## Avoid

- Do not send builder broad refactors or unknown file ownership.
- Do not chain investigator -> builder for 3+ file features; split work first.
- Do not ask reviewer for general feedback. It returns findings only.
- Paraphrase terse output before showing it directly to humans.

## Main Thread Duties

1. Define concrete task and ownership.
2. Tell workers they are not alone in the codebase and must not revert others' edits.
3. Avoid duplicate assignments.
4. Review returned changes before relying on them.
5. Integrate results into one coherent final answer.
