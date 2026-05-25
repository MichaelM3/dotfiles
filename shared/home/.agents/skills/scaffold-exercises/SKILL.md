---
name: scaffold-exercises
description: Scaffold AI Hero-style exercise directories with sections, problem/solution/explainer variants, and lintable readmes. Use only in repos that already use an exercises/ layout or `pnpm ai-hero-cli internal lint`, or when the user explicitly asks to create that course convention.
---

# Scaffold Exercises

Create exercise directory structures that pass the repo's exercise linter.

## Preconditions

- Existing `exercises/` directory or explicit user request to create it.
- Repo uses `pnpm ai-hero-cli internal lint`, or user confirms this convention.

## Naming

- Section: `exercises/XX-section-name/`
- Exercise: `XX.YY-exercise-name/`
- Names are lowercase dash-case.

## Variants

Each exercise needs at least one:

- `problem/`
- `solution/`
- `explainer/`

Default to `explainer/` for stubs unless the plan specifies variants.

## Required Files

Each variant has a non-empty `readme.md`:

```markdown
# Exercise Title

Short description.
```

If a variant contains code, add the required starter file for the repo
convention. Read existing exercises before choosing file names.

## Workflow

1. Parse sections, exercise names, numbers, and variants from the plan.
2. Inspect existing exercises for numbering and conventions.
3. Create directories and readme stubs.
4. Use `git mv` for renames.
5. Run `pnpm ai-hero-cli internal lint`.
6. Fix lint failures.

Do not commit unless the user explicitly asks.
