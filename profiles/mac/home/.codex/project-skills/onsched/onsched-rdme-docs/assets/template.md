# ReadMe guide page template (`rdme/docs/**`)

Use this structure for new or substantially rewritten guide pages. Match **YAML frontmatter** and heading patterns of a sibling in the same folder (see [`rdme/docs/Availability/getAvailability.md`](../../../rdme/docs/Availability/getAvailability.md)).

## Frontmatter (guides)

- Required shape per ReadMe Refactored sync: `title`, `slug`, `category.uri`, and a nested **`content`** block with **`excerpt`** (not a dotted `content.excerpt` key at the root — use nested YAML like sibling guides).

```yaml
---
title: Example guide
slug: example-guide
category:
  uri: Availability
content:
  excerpt: >-
    One-line summary for the docs hub.
---
```

Changelog posts use a different frontmatter shape — see [`rdme/changelog/README.md`](../../../rdme/changelog/README.md) (`privacy`, `metadata`, no `category`).

## Body sections (recommended order)

1. **Overview** — what this page covers and who it is for (integrators/operators).
2. **When to use** — bullet scenarios (when to call an endpoint or follow a flow).
3. **Prerequisites / required context** — auth, IDs, or setup needed first.
4. **Endpoints or workflow** — tables for routes, query/body fields with types and constraints.
5. **Request / response examples** — JSON with ASCII quotes; realistic UUIDs or placeholders.
6. **Errors** — link to error codes reference or domain-specific failures; align with [`api/controllers/`](../../../api/controllers/) behavior.
7. **See also** — links to [`rdme/docs/Glossary/terms.md`](../../../rdme/docs/Glossary/terms.md) and related guides in the same domain folder.

## Verification before merge

- Cross-check every behavioral claim against `api/controllers/<domain>/`, `api/validations/<domain>/`, and `api/schemas/` (note which files you read).
- Regenerate [`rdme/endpoints/openapi.json`](../../../rdme/endpoints/openapi.json) when HTTP contracts change; policy in [onsched-versioning.mdc](../../rules/onsched-versioning.mdc).

Changelog posts use different frontmatter — follow [`rdme/changelog/README.md`](../../../rdme/changelog/README.md).
