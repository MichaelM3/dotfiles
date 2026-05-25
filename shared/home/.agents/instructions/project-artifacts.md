# Project Artifacts

Shared rule for Matt-style project-local docs created or consumed by skills.

## Resolve Project Root

Before reading or writing project docs, resolve `PROJECT_ROOT`:

```bash
git rev-parse --show-toplevel
```

If that fails, ask before using the current working directory as the project
root. Never create project artifacts in global `/home/unbalanced/.agents`
unless the current project is this dotfiles repo and the user explicitly asked
for a global shared-harness artifact.

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
  issues/<feature-slug>/PRD.md
  issues/<feature-slug>/issues/01-slug.md
  out-of-scope/<slug>.md
```

## Lazy Creation

- `CONTEXT.md`: create only when the first domain term is resolved.
- `CONTEXT-MAP.md`: create only after the user confirms a multi-context layout.
- `adr/`: create only when the first ADR is accepted.
- `issues/`: create only when local markdown issue tracking is selected.
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
- Rejected enhancement memory: `.agents/out-of-scope/`.
