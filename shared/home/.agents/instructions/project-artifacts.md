# Project Artifacts

Shared rule for Matt-style project-local docs created or consumed by skills.

This rule overrides project-layout examples copied from upstream skills. Shared
skills are installed under `$HOME/.agents/skills`, but their outputs belong to
the active project. Never write project state into `$HOME/.agents`.

## Resolve Project Root

Before reading or writing project docs, resolve `PROJECT_ROOT`:

```bash
git rev-parse --show-toplevel
```

If that fails, ask before using the current working directory as the project
root. Never create project artifacts in global `$HOME/.agents`
unless the current project is this dotfiles repo and the user explicitly asked
for a global shared-harness artifact.

Resolve relative source-code paths from `PROJECT_ROOT`, even when the current
working directory is a nested package.

## Read Before Writing

Read existing project docs first:

- `PROJECT_ROOT/AGENTS.md`
- `PROJECT_ROOT/.agents/issue-tracker.md`
- `PROJECT_ROOT/.agents/triage-labels.md`
- `PROJECT_ROOT/.agents/domain.md`
- `PROJECT_ROOT/.agents/CONTEXT.md`
- `PROJECT_ROOT/.agents/CONTEXT-MAP.md`
- `PROJECT_ROOT/.agents/adr/`
- `PROJECT_ROOT/.agents/contexts/*/CONTEXT.md`
- `PROJECT_ROOT/.agents/contexts/*/adr/`
- Legacy root `CONTEXT.md`
- Legacy root `CONTEXT-MAP.md`
- Legacy root `docs/adr/`

Legacy root docs are compatibility inputs. Create new artifacts only under
`PROJECT_ROOT/.agents`.

## Layout

```text
PROJECT_ROOT/.agents/
  issue-tracker.md
  triage-labels.md
  domain.md
  CONTEXT.md
  CONTEXT-MAP.md
  adr/0001-slug.md
  contexts/<context-slug>/CONTEXT.md
  contexts/<context-slug>/adr/0001-slug.md
  issues/<feature-slug>/spec.md
  issues/<feature-slug>/issues/01-slug.md
  research/<slug>.md
  questionnaires/<slug>.md
  teaching/<topic-slug>/
  out-of-scope/<slug>.md
```

## Upstream Path Translation

When an imported Matt Pocock skill names an upstream path, translate it before
reading or writing:

- `docs/agents/issue-tracker.md` -> `.agents/issue-tracker.md`
- `docs/agents/triage-labels.md` -> `.agents/triage-labels.md`
- `docs/agents/domain.md` -> `.agents/domain.md`
- root `CONTEXT.md` -> `.agents/CONTEXT.md`
- root `CONTEXT-MAP.md` -> `.agents/CONTEXT-MAP.md`
- `docs/adr/` -> `.agents/adr/`
- context-local `CONTEXT.md` and ADRs -> `.agents/contexts/<context-slug>/`
- `.scratch/<feature>/spec.md` -> `.agents/issues/<feature>/spec.md`
- `.scratch/<feature>/issues/` -> `.agents/issues/<feature>/issues/`
- `.out-of-scope/` -> `.agents/out-of-scope/`

Legacy upstream paths remain read-only compatibility inputs. New artifacts use
the `.agents` locations above.

## Lazy Creation

- `CONTEXT.md`: create only when the first domain term is resolved.
- `CONTEXT-MAP.md`: create only after the user confirms a multi-context layout.
- `adr/`: create only when the first ADR is accepted.
- `issues/`: create only when local markdown issue tracking is selected.
- `research/`: create only when a research result must be persisted locally.
- `questionnaires/`: create only when a questionnaire is generated in a repo.
- `teaching/`: create only after confirming a repo-local teaching workspace.
- `out-of-scope/`: create only when an enhancement is rejected and the tracker
  workflow needs a durable rejection record.

## Paths By Purpose

- Issue tracker config: `.agents/issue-tracker.md`.
- Triage role mapping: `.agents/triage-labels.md`.
- Domain doc consumer rules: `.agents/domain.md`.
- Single-context glossary: `.agents/CONTEXT.md`.
- Multi-context map: `.agents/CONTEXT-MAP.md`.
- ADRs: `.agents/adr/` or `.agents/contexts/<context-slug>/adr/`.
- Local markdown PRDs/issues: `.agents/issues/<feature-slug>/`.
- Local markdown specs/tickets: `.agents/issues/<feature-slug>/`.
- Research notes: `.agents/research/`.
- Questionnaires: `.agents/questionnaires/`.
- Repo-local teaching workspaces: `.agents/teaching/<topic-slug>/`.
- Rejected enhancement memory: `.agents/out-of-scope/`.
