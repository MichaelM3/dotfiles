---
name: caveman-compress
description: Compress memory, instruction markdown, and prose files while preserving technical meaning and protected regions. Use when the user asks to compress docs, shorten instructions, reduce token footprint, or caveman-compress a file.
---

# Caveman Compress

Use for compressing memory files such as `AGENTS.md`, project notes, todos, and
preferences.

If `scripts/` is present, it may be used for deterministic validation. Manual
agent compression is also valid when no API key or dependency setup is available.

## Scope

Compress natural language only: `.md`, `.txt`, `.tex`, `.typ`, extensionless notes. Never compress source code, config, lockfiles, env files, scripts, SQL, XML, HTML, CSS, or generated files.

## Preserve Exactly

- Fenced and indented code blocks.
- Inline code.
- URLs, markdown links, paths, commands.
- API names, libraries, protocols, algorithms.
- Proper nouns, dates, versions, numbers, env vars.
- YAML/frontmatter keys and structure.
- Markdown heading text, list nesting, table structure.

## Compress

- Remove filler, pleasantries, hedging, duplicate examples, and redundant bullets.
- Replace long phrases: `in order to` -> `to`, `make sure to` -> `ensure`, `utilize` -> `use`.
- Use fragments when clear.
- Keep one representative example when several show same pattern.
- Do not reorder steps when order matters.

## File Safety

Before overwriting a user file, make a same-directory backup named `<file>.original.<ext>` unless the user says not to. For markdown memories, `<file>.original.md` is acceptable if that matches existing local convention. Never compress backup files. Re-read changed output and verify protected regions remained unchanged.
