---
name: onsched-v3
description: >-
  Always-on OnSched V3 Codex project guidance. Use when working in /home/unbalanced/Development/OnSched/v3, when the user mentions OnSched V3, or when editing this repo. Provides Codex-native routing, hard rules, read order, API/app/docs/release checklists, and points to focused native Codex skills without reading Cursor rules or Cursor skills.
---

# OnSched V3

## Purpose

Use this as the Codex-native project entrypoint for OnSched V3. It replaces the
runtime need to read `.cursor/rules/*` or `.cursor/skills/*`; those files remain
Cursor's source, not Codex's working context.

Default repo path: `/home/unbalanced/Development/OnSched/v3`.

## Startup

1. Work from the repo root when possible.
2. Read files before editing and match sibling style in the same directory.
3. Use the routing table below to load only the focused native Codex skills needed
   for the task.
4. If code, tests, and docs disagree after reading sources, stop and ask instead
   of guessing business behavior.

## Route By Task Or Path

| Scope | Native Codex guidance |
| --- | --- |
| `api/tests/**`, failed Mocha/Supertest, CI test shards | Skill `onsched-mocha-api-tests` |
| `api/routes/**`, `api/index.js` | Routing section below; v1 paths use `onsched-v1-shim` |
| `api/models/**`, `api/database/migrations/**` | Data Model section below |
| Availability slots, booking validation, `rdme/docs/Availability/**`, `availability-engine/**` | Skill `onsched-availability-debug` |
| V1 alias shim: `/consumer/v1`, `/setup/v1`, `v1Shim*`, `parseV1Token`, `test-apps/v1-compat/**` | Skill `onsched-v1-shim` |
| V1 bulk migration: `api/routes/migration.js`, `v1MigrationService`, `api/services/v1Migration/**` | Skill `onsched-v1-migration` |
| `rdme/docs/**`, `rdme/changelog/**`, public docs, ReadMe frontmatter | Skill `onsched-rdme-docs` |
| `.github/workflows/**` | Workflows section below |
| Changesets, changelog decision, OpenAPI regeneration, user-visible API/app behavior | Skill `onsched-versioning` |
| Multi-layer work across route/controller/service/validation/schema/docs/app/release | Skill `onsched-agent-handoff` |
| Written implementation plan before first edit | Skill `verify-plan` |
| Repo orientation, ownership, source-of-truth questions | Skill `onsched-architecture` |
| Local Docker, DB/Redis, local psql/redis-cli | Skill `onsched-local-dev` |
| Gatling load tests, `api/gatling/**`, `onsched_gatling` | Skill `onsched-gatling` |

Manual-only skills: `generate-commits` and `pr-summary`; use only when the user
explicitly asks.

## Hard Rules

- Layers stay `routes -> controllers -> services -> models`.
- Use ESM only: `import`/`export`, no `require()`.
- Label logs, for example `console.log("label:", value)`.
- Migrations are append-only; never edit shipped migrations. Add new `.cjs` files.
- In Sequelize transactions, pass `{ transaction }` to nested calls.
- Clear Redis availability cache after mutations that affect availability.
- Use `distinct: true` on `findAll` with includes when duplicate rows are possible.
- Never commit `.env` files.
- Quote PascalCase table names in raw SQL: `"User"`, `"Company"`,
  `"Appointment"`.
- Never log API keys, `Authorization` headers, tokens, passwords, Supabase
  secrets, or full request bodies that may contain them.
- User-visible API/app behavior needs the versioning decision and, when useful to
  customers or integrators, docs/changelog follow-through.

## API Guidance

- Generic API work lives under `api/controllers/**`, `api/services/**`,
  `api/validations/**`, `api/schemas/**`, `api/database/functions/**`,
  `api/connections/**`, `api/calendars/**`, `api/exceptions/**`, `api/utils/**`,
  and `api/enums/**`.
- Controllers translate request context and may throw typed API errors; services
  return domain data or throw typed API errors. Services do not call
  `res.status(...)`.
- Reuse errors under `api/exceptions/`, especially `apiError.js`,
  `parseApiError.js`, and `ServerError` patterns.
- Keep error responses aligned with the central handler:
  `success`, `message`, `errors`; do not expose stack traces, SQL, secrets, or
  env values.
- Keep `api/utils/logging/errorHandler.js` last in the Express stack.
- Status guide: `400` malformed input, `401` missing/invalid auth, `403`
  authenticated but not allowed, `404` missing resource, `409` conflicting state,
  `422` valid shape rejected by business rules, `500` unexpected server/provider
  failure.

## Routing

- `api/index.js` sets CORS, parsing, request IDs, `/health`, readiness gate, then
  mounts `api/routes/index.js`.
- Keep `/health` before readiness checks.
- Keep auth, validation, domain checks, and gating middleware before controllers.
- `/v3/public/*` keeps its public widget requirements; protected `/v3/*` routes
  must not bypass auth helpers.
- `POST /v3/oauth/token` is mounted in `api/routes/index.js` before other routers.
- V3 routes use `/v3/...`; route files own paths/middleware order, not business
  logic.
- V1 shims `api/routes/consumer.js` and `api/routes/setup.js` run before Swagger
  so catch-alls do not swallow shim paths.
- Swagger/OpenAPI docs are at `/docs`; `/` redirects to `/docs`.

## Data Model

- Read `api/models/relations.js` before queries with `include`; read individual
  `api/models/*.js` files for columns/options.
- New columns, indexes, uniques, or constraints require a new migration under
  `api/database/migrations/*.cjs`.
- Migration runbook: `api/docs/engineering/sequelize-migrations.md`.
- Booking sketches: `api/docs/database/domain-booking.md` and
  `api/docs/database/overview.md`; update only when core meaning changes.
- Domain terminology source: `rdme/docs/Glossary/terms.md`.

## App

- `app/**` is the merchant client portal for operators configuring company,
  schedules, settings, and account workflows. It is not the public booking or
  availability API surface.
- Supabase SSR auth requires valid `SUPABASE_URL` and `SUPABASE_ANON_KEY` or their
  Next.js public equivalents where pages load sessions.
- User-visible app behavior follows the same Changesets/changelog decision flow
  as API behavior.

## Workflows And Cloud

- `.github/workflows/api-tests.yml`: API test matrix on API path changes.
- `.github/workflows/changesets.yml`: dev-to-stage promotion opens/updates the
  Version packages PR into `dev`.
- `.github/workflows/rdme-sync.yml`: syncs `rdme/docs/**`, `rdme/changelog/**`,
  and `rdme/endpoints/openapi.json` to ReadMe on `stage`/`main`.
- Workflow edits should preserve existing OnSched test, release, and ReadMe sync
  behavior. Avoid generic CI patterns that do not match current branch flow.
- If using Google Cloud MCPs named `gcloud`, `observability`, or `cloud-run`, use
  read-only/list/get/log tools only. Do not deploy, patch, create, delete, bind,
  enable APIs, import/export SQL, or fetch full specs that expose env/secrets.

## AI Guidance Maintenance

- Keep Codex guidance under `/home/unbalanced/.codex` unless the user explicitly
  wants repo-visible guidance.
- Prefer updating an existing skill before adding a new one.
- Put always-needed routing and hard rules here; put procedural details in the
  focused domain skill.
- Avoid duplicating long lists across skills. Intentional safety duplicates are OK
  for secrets, migrations, transactions, cache invalidation, and user-visible
  release follow-through.
