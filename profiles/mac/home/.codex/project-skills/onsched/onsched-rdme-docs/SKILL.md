---
name: onsched-rdme-docs
description: >-
  Writes and maintains public ReadMe guides under rdme/docs and changelog posts under rdme/changelog: verifies claims against controllers, validations, schemas, tests, and OpenAPI; follows ReadMe Refactored nested frontmatter; updates glossary; chunks pages; respects rdme-sync.yml. Use for customer-facing markdown, HTTP flow docs, changelog posts, or prose alignment with shipping API behavior.
---

# OnSched - ReadMe Documentation

- Page structure template: `assets/template.md`.
- Changelog policy: `rdme/changelog/README.md` and skill `onsched-versioning`.
- CI sync: `.github/workflows/rdme-sync.yml`.

## When To Load

- Adding or editing guide pages under `rdme/docs/`.
- Adding or editing `rdme/changelog/` posts.
- Verifying public docs against shipped API behavior.

## Platform And CLI

Docs target ReadMe Refactored, not legacy ReadMe. The repo documents `rdme@10.6.2`
in `rdme/changelog/README.md`; CI uses `npx rdme@v10`.

## Frontmatter

Use nested YAML, not dotted legacy keys. `rdme docs upload` and
`rdme changelog upload` validate frontmatter; CI cannot answer interactive
auto-fix prompts.

- Guides can use nested `content:` fields such as `content.excerpt`.
- Changelog posts use nested `privacy:` and `metadata:`; do not use
  `content.excerpt` there.
- Match siblings in the same `rdme/docs/<Domain>/` folder.

## Verification Checklist

1. Read handlers under `api/controllers/<domain>/`.
2. Read request/response validation under `api/validations/<domain>/`.
3. Read relevant YAML under `api/schemas/` and, where useful, tests under
   `api/tests/`.
4. Verify names, required fields, enums, and error behavior.
5. If OpenAPI sources changed, run `node rdme/endpoints/generate-openapi.js` and
   commit `rdme/endpoints/openapi.json`.
6. If shared terminology changes, update `rdme/docs/Glossary/terms.md`.

## Audience

Write customer-facing observable behavior. Do not paste internal `api/docs/`,
deep SQL/CTE/Redis details, or debug notes into public guides unless the
customer-visible effect truly matters.

## Organization

Prefer several focused pages under the same domain folder over one long file. Use
clear H2s, cross-links, tables where they help scanning, and glossary links for
shared terms.

## Changelog Reuse

Before adding `rdme/changelog/vX-Y-Z-<topic>.md`, list existing changelog posts,
check root `package.json` version and pending Changeset bump, and prefer one
canonical `vX.Y.Z.md` for a pending release. Append sections and refresh
`metadata.description` instead of creating sibling descriptor files for the same
release.

## Availability Docs

For `rdme/docs/Availability/`, read product docs plus implementation through
`onsched-availability-debug`, then keep public prose about API-observable
behavior rather than CTE/cache internals.
