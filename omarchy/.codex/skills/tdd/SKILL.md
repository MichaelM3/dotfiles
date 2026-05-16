---
name: tdd
description: Test-driven development for Codex using red-green-refactor with vertical slices. Use when the user asks for TDD, red-green-refactor, test-first work, behavior coverage, or a bug fix that should start with a failing test.
---

# TDD

## Principle

Tests should verify behavior through public interfaces, not internal implementation. Prefer integration-style tests at the smallest useful surface: exported function, command, route, component behavior, or service boundary.

## Workflow

1. Identify the behavior that matters most. Ask only if local context cannot answer it safely.
2. Write one failing test for one vertical slice. Do not write the whole suite first.
3. Run only the narrow test and confirm it fails for the expected reason.
4. Implement the smallest production change that makes it pass.
5. Run the narrow test again.
6. Refactor only while green.
7. Repeat for the next behavior or edge case.
8. Finish with the relevant broader test command.

## Test Selection

- Start with critical paths, domain rules, bug regressions, and complex branching.
- Skip brittle tests for private helpers, implementation calls, and incidental DOM or database structure.
- Use mocks for true external dependencies, not for internal collaborators you can exercise directly.
- If no good test surface exists, name the architectural friction and keep the first test as high-level as necessary.

## Per-Cycle Checklist

- One behavior.
- One expected failure.
- One minimal implementation.
- Green before refactor.
- Existing behavior still covered.
