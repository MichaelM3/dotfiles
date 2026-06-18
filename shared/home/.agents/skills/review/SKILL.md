---
name: review
description: Review changes since a fixed point against documented standards and the originating spec. Use when the user asks to review a branch, PR, WIP diff, or changes since a ref.
---

# Review

Review the diff between `HEAD` and a fixed point along two axes:

- Standards: does the code follow documented repo standards?
- Spec: does the diff implement the originating issue, PRD, or spec?

## Process

1. Pin the fixed point. If the user did not provide one, ask for it.
2. Confirm it resolves with `git rev-parse <fixed-point>`.
3. Capture:
   - `git diff <fixed-point>...HEAD`
   - `git log <fixed-point>..HEAD --oneline`
4. Fail fast if the diff is empty.
5. Find spec source:
   - issue refs in commits
   - user-provided path or URL
   - PRD/spec under `.agents/issues/`, `docs/`, `specs/`, or similar
6. Find standards sources: `AGENTS.md`, `CONTRIBUTING.md`,
   `CODING_STANDARDS.md`, framework docs, or project rules.
7. Review both axes. Use subagents only when the user/session explicitly
   allows them; otherwise review sequentially in the main thread.

## Standards Axis

Report every place the diff violates a documented standard. Cite the standard
file and rule. Distinguish hard violations from judgment calls. Skip issues
that tooling already enforces unless the tool is absent or failing.

## Spec Axis

Report:

- requirements missing or partial
- behavior not asked for
- requirements that look implemented incorrectly

Quote or path-reference the spec for each finding. If no spec exists, say so
and skip this axis.

## Output

Lead with findings, ordered by severity within each axis. Keep Standards and
Spec separate; do not merge or rerank the two axes. End with counts and the
worst issue in each axis.
