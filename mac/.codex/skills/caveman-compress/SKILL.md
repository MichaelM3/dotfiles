---
name: caveman-compress
description: >-
  Compresses natural language memory files (AGENTS.md, project notes, todos, preferences) into caveman prose to save input tokens; preserves code blocks, URLs, paths. Overwrites original; backup `*.original.md`. Trigger: /caveman:compress PATH, caveman compress, compress memory file.
---

# Caveman Compress

## Purpose

Compress natural language files (project memory markdown, todos, preferences) into caveman-speak to reduce input tokens. Compressed version overwrites original. Human-readable backup saved as `<filename>.original.md`.

## Primary workflow (Codex)

No API key required. **onsched-agent-handoff** (or user) may ask the model to load this skill for long **markdown** notes only. Compress the target file in-editor per **Compression Rules** below: preserve code blocks, URLs, headings, paths exactly; shorten prose only.

Use this Codex skill's rules directly; the bundled CLI lives under this skill's `scripts/` directory.

## Optional scripted CLI

If `OPENAI_API_KEY` is set, the Python CLI can call an OpenAI-compatible Chat Completions API (`pip install openai`). Optional: `OPENAI_BASE_URL`, `CAVEMAN_MODEL` (default `gpt-4o-mini`). Without `OPENAI_API_KEY`, the CLI exits with instructions to use Codex instead.

From repo:

```bash
cd /home/unbalanced/.codex/skills/caveman-compress && python3 -m scripts <absolute_filepath>
```

The CLI will:

- detect file type (local)
- call completion API only when `OPENAI_API_KEY` is set
- validate output (local)
- if validation errors: targeted fix via completion API (same key), up to 2 retries
- on failure after retries: restore original, report error

## Compression Rules

### Remove

- Articles: a, an, the
- Filler: just, really, basically, actually, simply, essentially, generally
- Pleasantries: "sure", "certainly", "of course", "happy to", "I'd recommend"
- Hedging: "it might be worth", "you could consider", "it would be good to"
- Redundant phrasing: "in order to" → "to", "make sure to" → "ensure", "the reason is because" → "because"
- Connective fluff: "however", "furthermore", "additionally", "in addition"

### Preserve EXACTLY (never modify)

- Code blocks (fenced ``` and indented)
- Inline code (`backtick content`)
- URLs and links (full URLs, markdown links)
- File paths (`/src/components/...`, `./config.yaml`)
- Commands (`npm install`, `git commit`, `docker build`)
- Technical terms (library names, API names, protocols, algorithms)
- Proper nouns (project names, people, companies)
- Dates, version numbers, numeric values
- Environment variables (`$HOME`, `NODE_ENV`)

### Preserve Structure

- All markdown headings (keep exact heading text, compress body below)
- Bullet point hierarchy (keep nesting level)
- Numbered lists (keep numbering)
- Tables (compress cell text, keep structure)
- Frontmatter/YAML headers in markdown files

### Compress

- Use short synonyms: "big" not "extensive", "fix" not "implement a solution for", "use" not "utilize"
- Fragments OK: "Run tests before commit" not "You should always run tests before committing"
- Drop "you should", "make sure to", "remember to" — just state the action
- Merge redundant bullets that say the same thing differently
- Keep one example where multiple examples show the same pattern

CRITICAL RULE:
Anything inside ``` ... ``` must be copied EXACTLY.
Do not:

- remove comments
- remove spacing
- reorder lines
- shorten commands
- simplify anything

Inline code (`...`) must be preserved EXACTLY.
Do not modify anything inside backticks.

If file contains code blocks:

- Treat code blocks as read-only regions
- Only compress text outside them
- Do not merge sections around code

## Pattern

Original:
> You should always make sure to run the test suite before pushing any changes to the main branch. This is important because it helps catch bugs early and prevents broken builds from being deployed to production.

Compressed:
> Run tests before push to main. Catch bugs early, prevent broken prod deploys.

Original:
> The application uses a microservices architecture with the following components. The API gateway handles all incoming requests and routes them to the appropriate service. The authentication service is responsible for managing user sessions and JWT tokens.

Compressed:
> Microservices architecture. API gateway route all requests to services. Auth service manage user sessions + JWT tokens.

## Boundaries

- ONLY compress natural language files (.md, .txt, .typ, .typst, .tex, extensionless)
- NEVER modify: .py, .js, .ts, .json, .yaml, .yml, .toml, .env, .lock, .css, .html, .xml, .sql, .sh
- If file has mixed content (prose + code), compress ONLY the prose sections
- If unsure whether something is code or prose, leave it unchanged
- Original file is backed up as FILE.original.md before overwriting
- Never compress FILE.original.md (skip it)
