---
name: setup-matt-pocock-skills
description: Scaffold Matt Pocock-style per-repo skill config under PROJECT_ROOT/.agents for issue tracking, triage labels, and domain docs. Use before first use of to-prd, to-issues, triage, grill-with-docs, diagnose, tdd, architecture, or zoom-out in a repo, or when those skills lack tracker/domain context.
---

# Setup Matt Pocock Skills

Prompt-driven setup for shared Codex/Cursor skills. Explore, show findings,
ask one decision at a time, then write only after confirmation.

## Project Root

Follow `/home/unbalanced/.agents/instructions/project-artifacts.md`.
Resolve `PROJECT_ROOT` with `git rev-parse --show-toplevel`; if that fails,
ask before using the current directory. New project artifacts go only under
`PROJECT_ROOT/.agents`.

## Explore

Read what already exists:

- `git remote -v` and `.git/config`
- `AGENTS.md`
- `.agents/issue-tracker.md`
- `.agents/triage-labels.md`
- `.agents/domain.md`
- `.agents/CONTEXT.md`
- `.agents/CONTEXT-MAP.md`
- `.agents/adr/`
- Legacy root `CONTEXT.md`, `CONTEXT-MAP.md`, and ADRs

Summarize present/missing config before asking.

## Decisions

Ask these one at a time.

1. Issue tracker:
   - GitHub: use `gh`.
   - GitLab: use `glab`.
   - Local markdown: write PRDs/issues under `.agents/issues/`.
   - Other: record the user's one-paragraph workflow. Treat Linear as other
     unless a dedicated Linear adapter is requested later.
2. Triage labels:
   - Map canonical roles to tracker labels: `needs-triage`, `needs-info`,
     `ready-for-agent`, `ready-for-human`, `wontfix`.
   - Defaults are role names.
3. Domain docs:
   - Single context: `.agents/CONTEXT.md` and `.agents/adr/`.
   - Multi-context: `.agents/CONTEXT-MAP.md` and
     `.agents/contexts/<context-slug>/`.
   - Create `.agents/CONTEXT-MAP.md` only after explicit multi-context
     confirmation.

## Draft

Show the exact planned changes:

- `AGENTS.md` `## Agent skills` block, if present or user approves creating it.
- `.agents/issue-tracker.md`
- `.agents/triage-labels.md`
- `.agents/domain.md`

Use the references in this folder as seeds:

- `references/issue-tracker-github.md`
- `references/issue-tracker-gitlab.md`
- `references/issue-tracker-local.md`
- `references/triage-labels.md`
- `references/domain.md`

## Write

- Update an existing `## Agent skills` block in `AGENTS.md`; avoid duplicates.
- If `AGENTS.md` does not exist, ask before creating it.
- Do not create glossaries, ADRs, or local issue files during setup unless the
  user explicitly asks. Those are lazy artifacts.

## Done

Report which files changed and which skills will read them.
