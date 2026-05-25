---
name: migrate-to-shoehorn
description: Migrate TypeScript test data from `as` assertions to @total-typescript/shoehorn. Use only in TypeScript repos with package.json when the user mentions shoehorn, wants to replace `as` in tests, or needs safer partial test fixtures.
---

# Migrate To Shoehorn

Use `@total-typescript/shoehorn` in tests only. Never introduce it into
production code.

## Preconditions

- `package.json` exists.
- TypeScript test files exist.
- User asked for shoehorn or partial test fixture migration.

If preconditions fail, explain and stop.

## Workflow

1. Detect package manager from lockfile.
2. Install `@total-typescript/shoehorn` as a dev dependency using the repo's
   package manager.
3. Find test assertions:
   - `rg -n " as [A-Z][A-Za-z0-9_]*|as unknown as" --glob '*.{test,spec}.ts'`
4. Replace:
   - `value as Type` with `fromPartial(value)` when partial data is valid.
   - `value as unknown as Type` with `fromAny(value)` for intentionally invalid
     data.
   - Full valid objects may use `fromExact(value)` if useful.
5. Add imports from `@total-typescript/shoehorn`.
6. Run typecheck and relevant tests.

## Rules

- Migrate one file or coherent test area at a time.
- Preserve intentionally invalid test data.
- Do not use shoehorn to hide real production type problems.
