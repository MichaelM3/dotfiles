# Project Instructions

Load repository-local docs first:

- `AGENTS.md`
- `.agents/issue-tracker.md`
- `.agents/triage-labels.md`
- `.agents/domain.md`
- `.agents/CONTEXT.md`
- `.agents/CONTEXT-MAP.md`
- `.agents/adr/`
- `.agents/contexts/*/CONTEXT.md`
- `.agents/contexts/*/adr/`
- Legacy root `CONTEXT.md`, `CONTEXT-MAP.md`, and ADRs if present
- Framework docs

Then apply shared harness guidance from:

`$HOME/.agents/AGENTS.md`

Project-local agent artifacts live under `PROJECT_ROOT/.agents`. Follow the
shared project artifact contract:

`$HOME/.agents/instructions/project-artifacts.md`

Keep project-specific commands, workflows, release rules, and domain skills in
this repo or a project-local profile.
