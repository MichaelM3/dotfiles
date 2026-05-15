---
name: onsched-architecture
description: >-
  Orients readers to the OnSched V3 repo: stack, layout, layers, tests vs app, availability vs merchant portal, rdme/docs vs api/ read order, and where release/OpenAPI/data-model sources live. Use for onboarding, refactors, or answering where code or docs live.
---

# OnSched - Architecture Read Order

Canonical detail lives in `/home/unbalanced/Development/OnSched/v3/api/docs/ARCHITECTURE.md`; this skill is the
compact navigation layer.

## When To Load

- Answering "where does X live?"
- Refactoring across API, app, docs, and release artifacts.
- Choosing the source of truth for product behavior, API contract, data model, or
  docs.
- Building a quick mental model before editing.

## Stack

- Root package: `onsched-v3`; Changesets and shared release tooling live at repo
  root.
- API: Express, Sequelize, PostgreSQL, Redis, ESM, Mocha/Chai/Supertest.
- App: Next.js merchant portal in `app/`; Supabase SSR auth.
- Docs/API reference: public guides in `rdme/docs/**`; generated OpenAPI bundle in
  `rdme/endpoints/openapi.json`.

## Read Order

1. Internal hub: `api/docs/README.md`; architecture: `api/docs/ARCHITECTURE.md`.
2. Product behavior: `rdme/docs/<Domain>/` plus glossary
   `rdme/docs/Glossary/terms.md`.
3. API contract: `api/routes/`, `api/controllers/`, `api/services/`,
   `api/validations/`, `api/schemas/`, and `rdme/endpoints/openapi.json`.
4. Data model: `api/models/relations.js`, individual `api/models/*.js`, and new
   migrations under `api/database/migrations/*.cjs`.
5. Availability: `rdme/docs/Availability/`, `availability-engine/`,
   `api/docs/availability/availability-cache.md`, SQL under
   `api/database/functions/getAvailability/`, and skill
   `onsched-availability-debug`.
6. V1 compatibility: alias shim skill `onsched-v1-shim`; bulk migration skill
   `onsched-v1-migration`; external v1 reference `https://docs.onsched.com/v1.0`.
7. Merchant portal: `app/**`; operator workflows, not public booking traffic.
8. Releases: `VERSIONING.md`, `.changeset/README.md`, and skill
   `onsched-versioning`.

Environment skill: `onsched-local-dev`. Test/load skills:
`onsched-mocha-api-tests`, `onsched-gatling`.
