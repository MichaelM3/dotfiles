# Issue Tracker: Local Markdown

Issues and PRDs live under `PROJECT_ROOT/.agents/issues/`.

## Layout

```text
.agents/issues/<feature-slug>/
  PRD.md
  issues/01-slug.md
  issues/02-slug.md
```

## Conventions

- One feature directory per PRD or plan.
- PRD path: `.agents/issues/<feature-slug>/PRD.md`.
- Issue path: `.agents/issues/<feature-slug>/issues/<NN>-<slug>.md`.
- Triage state: `Status: <role>` near the top of each issue file.
- Comments: append under `## Comments` when useful.

Create `.agents/issues/` lazily when the first local PRD or issue is published.
