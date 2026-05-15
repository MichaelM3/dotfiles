---
name: generate-commits
description: >-
  Manual workflow: inspect git state; if history already clean, no-op; if one oversized commit, split only when needed; if working tree has uncommitted work, group into Conventional Commit-sized commits. Uses git commit -m title -m body. Invoke via /generate-commits or explicit request only.
---

# Generate commits (`/generate-commits`)

Manual skill—do not auto-load from ambient context.

## Invoke

| User says | Action |
| --- | --- |
| `/generate-commits` | Run full diagnose → branch below |
| `@generate-commits` + extra | Same; extra line = optional focus (path, ticket, base branch) |

Run from **repo root**. Needs `git_write` if agent runs commits for user.

## Safety (before rewrite)

- **Never** `reset --soft` / rebase to split commits that are **already on shared remote** without explicit user OK (implies `push --force-with-lease` and team policy). Check: `git status -sb`, `git log @{u}..HEAD`, `git merge-base HEAD @{u}`.
- If ambiguous or risky → stop; list options; let user choose.

## Message format (required)

Always use **two** `-m` flags: subject (title) then body (summary). Omit body only when change is small and motivation is obvious; add body for breaking changes, security fixes, migrations, or multi-file intent that subject alone would hide.

```bash
git commit -m "type(scope): imperative subject under 72 chars" -m "Body: why, not restatement of diff.
Wrap near 72 cols. Bullets with - for lists.
Refs #123"
```

- **Subject:** [Conventional Commits](https://www.conventionalcommits.org/) — `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `build`, `ci`, etc.; imperative mood; no trailing period on subject; prefer ≤50 chars when practical.
- **Extra paragraphs:** repeat `-m "..."` (Git concatenates with blank lines).
- **Shell:** quote both strings; for multiline in one `-m`, use `$'...\\n...'` or heredoc — avoid unescaped backticks inside commands.

## Diagnose → branch

1. `git status --short` — unstaged/untracked?
2. `git log --oneline -20` — shape of recent history (many small vs one blob)?
3. Optional: `git log --oneline origin/dev..HEAD` (or user-named base) — what this branch adds.

### Branch A — Clean working tree + history already neat

**Neat** ≈ commits are **small, one concern each**, messages follow CC + title/body pattern where needed.

→ **Do nothing.** One line: why history OK (e.g. "3 commits vs dev; each single-type; messages valid").

### Branch B — Clean tree + **one** large commit (vs base) that **mixes** concerns

Only act when split **adds value** (bisect, review, changelog). If the single commit is one feature + one scope → **leave it**.

If split:

1. Confirm not pushed or user accepts rewrite.
2. `git reset --soft HEAD~1` (one commit back) — restage in logical slices.
3. Order: `chore`/`build` deps → `fix` → `feat`; `docs`/`test` can follow or parallel by area.
4. For each slice: `git add` paths (or `git add -p`), then `git commit -m ... -m ...`.

If **cannot** rewrite → suggest **follow-up commits** that refactor only when it doesn't lie about history (usually prefer honest single commit over fake "fixup" noise).

### Branch C — **Uncommitted** work (or mixed staged/unstaged)

Chunk by **intent**, not by file count:

| Intent | type | Examples |
| --- | --- | --- |
| New behavior / API | `feat` | endpoints, flags, user-visible behavior |
| Bug | `fix` | incorrect behavior, crashes |
| Docs only | `docs` | README, rdme, comments that document API |
| Tests only | `test` | specs, snapshots |
| Refactor no behavior | `refactor` | move code, rename internal |
| Tooling / format | `chore`, `ci`, `build` | eslint, deps, workflow |

Group files; stage minimal set per commit; commit with `-m` `-m`. Repeat until `git status` clean.

**Order:** dependencies first (types, config, migrations before callers) when order matters.

## Anti-patterns

- One commit titled `update stuff` mixing feat + fix + chore.
- Splitting so every file = one commit (noise).
- Rewriting pushed history silently.
- Subject-only when the change clearly needs a body (breaking change, security, migration) but none was added — fix the message.

## Related

- Terse subject + when to expand body: same rules as above (this skill).
- After commits on branch: **pr-summary** for PR into `dev`
