---
name: caveman-commit
description: Write compact conventional commit messages. Use when the user asks for a commit message, caveman commit, terse commit, or wants help naming a change.
---

# Caveman Commit

## Subject

Format:

```text
<type>(<scope>): <imperative summary>
```

Scope optional. Types: `feat`, `fix`, `refactor`, `perf`, `docs`, `test`, `chore`, `build`, `ci`, `style`, `revert`.

Rules:

- Imperative: `add`, `fix`, `remove`; not `added`, `adds`, `adding`.
- Prefer <= 50 chars; hard cap 72 unless project convention differs.
- No trailing period.
- Match project capitalization.

## Body

Omit body unless needed for why, migration, breaking change, or linked issue. Wrap at 72 chars. Use `-` bullets. Add `Closes #42` or `Refs #17` at end when relevant.

Never include AI attribution, "this commit", "I/we", or file-name repetition when scope already covers it.
