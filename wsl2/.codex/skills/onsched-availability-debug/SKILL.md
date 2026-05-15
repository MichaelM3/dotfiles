---
name: onsched-availability-debug
description: >-
  Debugs OnSched booking availability: pre-edit read order, CTE step logs, GET /v3/availability repros, validateTimeSlotAvailability single-slot checks, Redis cache invalidation, test fixtures/mocks, regression tests after bugfixes, optional EXPLAIN ANALYZE on SQL from getAvailability modules. Use for availability bugs, wrong slots, slot validation failures, CTE results, query performance, DEBUG_LOGS, Redis availability cache, or rdme/docs/Availability.
---

# OnSched - Availability Debugging

Do not guess slot behavior. Read product and engine context first, then code.

## When To Load

- Wrong or missing `GET /v3/availability` slots need a real repro.
- `validateTimeSlotAvailability` disagrees with slot-list behavior or booking
  outcomes.
- You need `DEBUG_LOGS`, CTE-by-CTE inspection, Redis cache invalidation, or
  regression tests.
- You need `EXPLAIN`, Query Insights correlation, or local profiling for
  availability SQL.

## Pre-Edit Checklist

1. Read public behavior in `rdme/docs/Availability/`.
2. Read relevant specs in `availability-engine/` before changing SQL or controller
   logic.
3. Read `api/docs/availability/availability-cache.md` before touching
   slot-affecting code.
4. Read `api/database/functions/getAvailability.js` before editing fragments under
   `api/database/functions/getAvailability/`.
5. If booking-time slot checks are involved, read
   `api/database/functions/validateTimeSlotAvailability.js`.
6. Capture a baseline by running focused availability tests, or note that no
   focused test exists yet.
7. Decide cache impact before editing: identify affected `ServiceId`,
   `ResourceId`, and `LocationId`, or confirm no cached availability is affected.

## Prereqs

- Postgres and Redis running: local Docker skill `onsched-local-dev`; in Codex
  sandboxes, use the normal command escalation flow if service startup needs
  permissions outside the workspace.
- Product flow: `rdme/docs/Availability/`; engine notes:
  `availability-engine/*.md`; cache behavior:
  `api/docs/availability/availability-cache.md`; architecture gotchas:
  `api/docs/ARCHITECTURE.md`.

## CTE Step Logging

- Implementation: `api/controllers/availability/availabilityDebugger.js`.
- Enabled when `process.env.DEBUG_LOGS === 'true'` in
  `api/controllers/availability/availabilityController.js`.
- Run API with `DEBUG_LOGS=true npm run dev` from `api/`, then issue the exact
  repro `GET /v3/availability` query.

## Redis Cache

- After creating/updating appointments, unavailability, schedules, or anything
  that affects slots, invalidate cached keys for affected UUIDs.
- Pattern: `availability:*_<uuid>*`; helper:
  `api/utils/cache/redisDeleteByUuid.js`.
- Tests/helpers: `clearAvailabilityCache(...uuids)` in
  `api/tests/helpers/availabilityTestHelpers.js`.

## Tests And Repros

- Prefer `api/tests/__mocks__/`, `api/tests/helpers/fixtures.js`, and existing
  tests under `api/tests/availability/`.
- Use sibling Supertest patterns for API-shaped repros.
- Clear or bypass cache when asserting fresh slot behavior.
- After a bugfix, add or update a regression test that fails on old behavior.

## SQL And Profiling

- CTE modules live under `api/database/functions/getAvailability/`; the barrel is
  `api/database/functions/getAvailability.js`.
- Profiling guide: `api/docs/engineering/db-query-profiling.md`.
- Local sweep helper from `api/`:
  `ENV=dev PG_HOST=localhost node scripts/explain-availability-param-sweep.mjs`.
- For ad hoc profiling, run `EXPLAIN (ANALYZE, BUFFERS)` with SQL and
  replacements matching the real query.

## Single-Slot Validation

`api/database/functions/validateTimeSlotAvailability.js` validates a specific
booking slot and reuses CTE pieces from `getAvailability.js`. Tests live under
`api/tests/availability/`, including `validateTimeSlotAvailability.test.js`.
