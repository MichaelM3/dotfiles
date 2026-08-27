---
name: setup-matt-pocock-skills
description: "Configure the active repo for Matt Pocock-style engineering skills: issue tracking, triage labels, and domain docs under PROJECT_ROOT/.agents. Run once before first use of those workflows."
disable-model-invocation: true
---

# Setup Matt Pocock Skills

Scaffold per-repo configuration for machine-level shared skills. Explore,
present findings, ask one decision at a time, and write only after confirmation.

## Project Root

Follow `$HOME/.agents/instructions/project-artifacts.md`. Resolve
`PROJECT_ROOT` with `git rev-parse --show-toplevel`; if that fails, ask before
using the current directory. All generated files go under
`PROJECT_ROOT/.agents`, never the shared skill installation.

## Explore

Read what already exists:

- `git remote -v`, `.git/config`, `AGENTS.md`, and `CLAUDE.md`
- `.agents/issue-tracker.md`, `.agents/triage-labels.md`, `.agents/domain.md`
- `.agents/CONTEXT.md`, `.agents/CONTEXT-MAP.md`, `.agents/adr/`, and contexts
- Legacy root `CONTEXT.md`, `CONTEXT-MAP.md`, `docs/adr/`, `docs/agents/`,
  `.scratch/`, and `.out-of-scope/`
- Whether `triage` is installed
- Monorepo signals such as `pnpm-workspace.yaml`, package workspaces, or
  populated `packages/*`

Summarize present and missing config before asking.

## Decisions

Take these sections in order, one answer at a time. Skip a section when
exploration already settled it.

### Issue Tracker

Recommend GitHub for a GitHub remote, GitLab for a GitLab remote, otherwise
offer local markdown. Choices:

- GitHub via `gh`
- GitLab via `glab`
- Local markdown under `.agents/issues/`
- Other, recorded as the user's one-paragraph workflow

Keep external PR triage disabled by default. Record the choice in
`.agents/issue-tracker.md`.

### Triage Labels

Skip when `triage` is not installed. Otherwise ask whether to keep the default
labels: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, and
`wontfix`. Collect overrides only when the user declines.

### Domain Docs

Default silently to a single context. Offer multi-context only when monorepo
signals exist and create `.agents/CONTEXT-MAP.md` only after confirmation.

## Draft And Write

Show exact drafts before writing:

- An `## Agent skills` block for an existing `CLAUDE.md` or `AGENTS.md`
- `.agents/issue-tracker.md`
- `.agents/triage-labels.md` when triage is installed
- `.agents/domain.md`

Prefer an existing `CLAUDE.md`, then an existing `AGENTS.md`. If neither
exists, ask which one to create. Update an existing `## Agent skills` block in
place and preserve surrounding user content.

Use this folder's seed files, translating their documented output paths to
`.agents` as required by the shared project-artifact policy:

- `issue-tracker-github.md`
- `issue-tracker-gitlab.md`
- `issue-tracker-local.md`
- `triage-labels.md`
- `domain.md`

Do not create glossaries, ADRs, local tickets, research notes, or questionnaires
during setup. Those artifacts are lazy.

## Done

Report changed files and which skills consume them. Re-running setup is needed
only to change this repo's workflow configuration.
