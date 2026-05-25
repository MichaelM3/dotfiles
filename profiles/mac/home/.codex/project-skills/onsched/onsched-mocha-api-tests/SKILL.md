---
name: onsched-mocha-api-tests
description: >-
  Runs and debugs OnSched API tests with Mocha, Chai, and Supertest: db reset hooks, test:file, smoke, unit vs integration shards, skipDbReset, clearAvailabilityCache, CI matching api-tests.yml, and local env. Use when npm test fails, a single it() misleads, or API test workflow is needed.
---

# OnSched - Mocha API Tests

## When To Load

- `npm test`, `npm run test:file`, `npm run test:smoke`, `npm run test:unit`,
  `npm run test:availability`, or `npm run test:integration-rest` is failing.
- A single `it()` passes but the whole file fails or behaves differently.
- You need `skipDbReset`, ordered suites, CI shard behavior, or
  `clearAvailabilityCache`.

## Commands From `api/`

- Full integration suite: `npm test`
- Unit only, no DB/Redis: `npm run test:unit`
- Availability + allocation + validate-slot lane: `npm run test:availability`
- Non-availability integration shard: `npm run test:integration-rest`
- One file: `npm run test:file -- tests/integration/<name>.test.js` or
  `tests/availability/<name>.test.js`
- Fast smoke: `npm run test:smoke`
- Timing detail: `TEST_TIMING=1 npm test`

## Environment And CI

- Test env: `NODE_ENV=test`, `ENV=test`, `PORT=3101`, `.env.test`.
- Needs Postgres and Redis: skill `onsched-local-dev`; in Codex sandboxes, use
  normal command escalation if service startup needs permissions outside the
  workspace.
- CI: `.github/workflows/api-tests.yml`, PRs and pushes to `dev`, matrix
  `test:unit`, `test:integration-rest`, `test:availability`; integration shards
  run `db:reset` and Mocha with `--forbid-only`.

## Gotchas

- Run the whole file; order within a file may matter.
- Suites can set `this.skipDbReset` or `this.ctx.skipDbReset` in `before`.
- After availability-impacting setup, use `clearAvailabilityCache` from
  `api/tests/helpers/availabilityTestHelpers.js`.
- V1-shim logs: `LOG_V1_SHIM`, `LOG_V1_MIGRATION`.

## Availability Failures

Use `onsched-availability-debug`; reuse fixtures in
`api/tests/helpers/fixtures.js` and sibling patterns in `api/tests/__mocks__/`
and `api/tests/availability/`.
