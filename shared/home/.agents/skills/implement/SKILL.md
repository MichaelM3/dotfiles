---
name: implement
description: Implement a piece of work from a PRD, issue, or approved plan. Use when the user invokes implement or asks to execute a specified slice.
disable-model-invocation: true
---

# Implement

Implement only the work described by the user, PRD, issue, or approved plan.

## Inputs

Read the supplied PRD/issue/plan first. If it references project docs, follow
`/home/unbalanced/.agents/instructions/project-artifacts.md` and read relevant
glossaries, ADRs, tracker config, and triage labels.

## Workflow

1. Restate scope, acceptance criteria, likely files, and verification command.
2. Identify the highest useful test seam. Use `codebase-design` for interface
   and seam decisions.
3. Use `tdd` where practical: one failing vertical slice, minimal green,
   refactor while green, repeat.
4. Run focused checks regularly: narrow test, typecheck, lint, or repro command.
5. Keep changes scoped. Do not bundle unrelated refactors.
6. Run the broadest relevant check at the end.
7. Review the diff before reporting; use `review` if the user requested that
   flow or the repo has a spec/standards review convention.

## Commit Rule

Do not commit unless the user explicitly asked for a commit or the current task
was explicitly framed as a commit-producing flow. If committing, preserve
unrelated worktree changes and commit only the intended files.

## Done

Report changed files, verification, any skipped checks, and remaining risk.
