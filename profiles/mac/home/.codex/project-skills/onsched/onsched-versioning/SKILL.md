---
name: onsched-versioning
description: >-
  Applies Changesets, ReadMe changelogs, and OpenAPI regeneration for OnSched V3; version bumps run through changeset version and mirror script, not hand-editing three package.json files. Use when adding a changeset, shipping user-visible API or app behavior, regenning openapi.json, or during dev to stage promotion. For user-visible work in api/app paths, also follow the routing and handoff guidance in onsched-v3.
---

# OnSched V3 — versioning and changelogs

- **Policy:** [`VERSIONING.md`](/home/unbalanced/Development/OnSched/v3/VERSIONING.md)
- **Changesets:** [`.changeset/README.md`](/home/unbalanced/Development/OnSched/v3/.changeset/README.md) — `npx changeset` at repo root, package **`onsched-v3`** only.
- **Apply version + mirror + OpenAPI:** `npm run version-packages` from repo root, or the **Changesets** workflow ([`changesets.yml`](/home/unbalanced/Development/OnSched/v3/.github/workflows/changesets.yml)) when a **promotion PR (`dev` → `stage`)** is open, which **opens/updates a Version PR into `dev`**. Add changeset files on **`dev`**; merge the Version PR into **`dev`**, then merge **`dev` → `stage`**.
- **Releases (tags, ReadMe `rdme`):** [`.github/RELEASE.md`](/home/unbalanced/Development/OnSched/v3/.github/RELEASE.md)
- **Changelog how-to:** [`rdme/changelog/README.md`](/home/unbalanced/Development/OnSched/v3/rdme/changelog/README.md) — filenames are **version-first** (e.g. `v3.1.0.md`, or `v3.0.0-staging-preview.md` for staging preview), not date-prefixed.

## When to load this skill

- Adding a Changeset or deciding whether a change needs one.
- Shipping user-visible API or app behavior.
- Regenerating OpenAPI after annotation/schema changes.
- Preparing a promotion PR or version-application step.

## Core rules

- Do **not** bump `version` in root, `api`, and `app` by hand for ordinary PRs — use **`.changeset/*.md`** and later **`version-packages`**.
- Root `package.json` is the source of truth; `version-packages` mirrors to `api`, `app`, and `rdme/endpoints/openapi.json`.
- Merge the **Version packages** PR into `dev` before merging `dev` → `stage`.

## Commands

- Add intent file: `npx changeset`
- Apply version + mirror + OpenAPI: `npm run version-packages`
- Regenerate OpenAPI on a branch when sources changed: `node rdme/endpoints/generate-openapi.js` (from repo root)

## Changelog frontmatter reminders

- Use version-first filenames such as `v3.1.0.md`; prefer **one** canonical `vX.Y.Z.md` per pending release and **append** sections instead of adding multiple `vX.Y.Z-<descriptor>.md` siblings (see [`rdme/changelog/README.md`](/home/unbalanced/Development/OnSched/v3/rdme/changelog/README.md)).
- Use **nested** YAML for ReadMe Refactored (`privacy:` / `metadata:`), **not** dotted keys (`privacy.view`, `metadata.description`) — dotted keys break CI `changelog upload` with an interactive prompt.
- Set `privacy.view` via nesting:

```yaml
privacy:
  view: public
```

- Summary line for the changelog hub: nested `metadata.description`. Do **not** use **`content.excerpt`** on changelog posts (that shape is for guides under `content:`); put narrative in the Markdown body.

### Reuse pending changelog

Before creating `rdme/changelog/vX-Y-Z-<topic>.md`, list existing `rdme/changelog/v*.md`, compare with root [`package.json`](/home/unbalanced/Development/OnSched/v3/package.json) version and the pending Changeset bump. If a file for the target `vX.Y.Z` already exists, add a new `##` section and update `metadata.description` instead of a new file.

## Single source of truth (OpenAPI)

- Root [`package.json`](/home/unbalanced/Development/OnSched/v3/package.json) `version` is read by [`api/openapiDefinition.js`](/home/unbalanced/Development/OnSched/v3/api/openapiDefinition.js). After a version bump, `scripts/mirror-version-and-openapi.mjs` (via `version-packages`) syncs to `api` and `app` and runs `rdme/endpoints/generate-openapi.js`.

| Step | What runs |
| --- | --- |
| `npx changeset` | Add intent file under `.changeset/` |
| `changeset version` (inside `version-packages`) | Bumps **root** `version` (only `onsched-v3` in the graph) |
| `mirror-version-and-openapi.mjs` | Copies version to `api`/`app`, runs `generate-openapi.js` |

- Commit `rdme/endpoints/openapi.json` whenever `@openapi`, `api/schemas/`, or `api/openapiDefinition.js` changes.

## What agents must not do

- Drift: no mismatched `version` across the three `package.json` files after a release step.
- Duplicating: no second OpenAPI `info` block outside `api/openapiDefinition.js`.

## Git (humans on release)

Tags and ReadMe: see `VERSIONING.md` and `.github/RELEASE.md`. Agents do not create tags unless the user asks.
