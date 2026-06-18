---
name: tdd
description: Test-driven development for coding agents using red-green-refactor with vertical slices. Use when the user asks for TDD, red-green-refactor, test-first work, behavior coverage, or a bug fix that should start with a failing test.
---

# TDD

## Project Context

Before writing tests, follow
`/home/unbalanced/.agents/instructions/project-artifacts.md`. Read relevant
domain docs and ADRs so test names, interfaces, and examples use project
vocabulary.

## Principle

Tests should verify behavior through public interfaces, not internal implementation. Prefer integration-style tests at the smallest useful surface: exported function, command, route, component behavior, or service boundary.

Use `/home/unbalanced/.agents/skills/codebase-design/SKILL.md` when choosing or
designing the test seam.

See references when needed:

- `references/tests.md`
- `references/mocking.md`
- `references/refactoring.md`

## Anti-Pattern

Do not write all tests first, then all implementation. That horizontal slice
locks tests to imagined shapes. Use tracer bullets: one failing test, one
minimal implementation, one green check, then repeat.

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
- Prefer deep modules: small public interface, substantial hidden behavior,
  tests at the same interface callers use.

## Per-Cycle Checklist

- One behavior.
- One expected failure.
- One minimal implementation.
- Green before refactor.
- Existing behavior still covered.
