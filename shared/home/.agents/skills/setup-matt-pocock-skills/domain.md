# Domain Docs

How engineering skills consume this repo's project-local domain documentation.

## Before Exploring

Resolve the repository root, then read relevant files under `.agents/`:

- `CONTEXT.md`, or `CONTEXT-MAP.md` plus relevant context glossaries
- System ADRs under `adr/`
- Context ADRs under `contexts/<context-slug>/adr/`

Legacy root `CONTEXT.md`, `CONTEXT-MAP.md`, and `docs/adr/` are read-only
compatibility inputs. Missing files are normal; domain-modeling creates them
lazily when terms or decisions crystallize.

## Layout

Single context:

```text
.agents/
  CONTEXT.md
  adr/
```

Multiple contexts:

```text
.agents/
  CONTEXT-MAP.md
  adr/
  contexts/<context-slug>/
    CONTEXT.md
    adr/
```

Use glossary vocabulary in issues, refactor proposals, hypotheses, tests, and
code. Surface conflicts with accepted ADRs instead of silently overriding them.
