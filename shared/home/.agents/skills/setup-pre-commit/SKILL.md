---
name: setup-pre-commit
description: Add Husky, lint-staged, Prettier, and optional typecheck/test pre-commit hooks to JavaScript or TypeScript package repos. Use only when package.json exists and the user asks to set up pre-commit hooks or lint-staged.
---

# Setup Pre-Commit

Set up repo-local pre-commit checks without overwriting existing workflow.

## Preconditions

- `package.json` exists.
- User asked for pre-commit hooks, Husky, lint-staged, or commit-time checks.

If preconditions fail, stop and explain.

## Process

1. Detect package manager by lockfile: pnpm, npm, yarn, bun.
2. Read existing `package.json`, Husky config, lint-staged config, and Prettier
   config.
3. Install dev dependencies: `husky`, `lint-staged`, `prettier` unless already
   present.
4. Initialize or update Husky for the detected package manager.
5. Create/update `.husky/pre-commit`:
   - run lint-staged
   - run typecheck only if a script exists
   - run tests only if a script exists and user wants full test cost at commit
6. Create/update lint-staged config:

```json
{
  "*": "prettier --ignore-unknown --write"
}
```

7. Add a Prettier config only if none exists.
8. Verify the hook and `lint-staged` command.

Do not commit unless the user explicitly asks.
