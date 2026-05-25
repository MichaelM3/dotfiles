---
name: onsched-v1-shim
description: >-
  Procedure for the v1 alias shim (/consumer/v1, /setup/v1): auth, translator, LegacyIdMap, allowlist vs 410 Gone, and compatibility-only constraints. Load when editing api/routes/consumer.js, api/routes/setup.js, api/controllers/v1shim/consumer.js, api/controllers/v1shim/setup.js, api/services/v1ShimService.js, v1SetupShimService.js, v1ShimTranslator.js, v1Shim/**, parseV1Token, v1ApiClient, v1AllocationUtils, or test-apps/v1-compat; or when debugging v1-shaped responses on the v3 host.
---

# OnSched — V1 alias shim workflow

## When to load this skill

- Any edit to consumer/setup v1 routes, shim controllers, `V1ShimService`, `V1SetupShimService`, `v1ShimTranslator`, `v1Shim/shared`, `parseV1Token`, `v1ApiClient`, `v1IdentityService`, `v1AllocationUtils`.
- Integrators report **410 Gone**, wrong ID resolution, or response shape mismatches on `v3.onsched.com` with `/consumer/v1` or `/setup/v1` paths.
- Before adding a new shim route or changing translator mapping.

## Read first (canonical)

1. [`rdme/docs/GetStarted/v1AliasEndpoints.md`](/home/unbalanced/Development/OnSched/v3/rdme/docs/GetStarted/v1AliasEndpoints.md) — allowlist, auth caveats, known gaps, `/unavailable` proxy note.
2. [`api/docs/ARCHITECTURE.md`](/home/unbalanced/Development/OnSched/v3/api/docs/ARCHITECTURE.md) — shim placement and response differences.
3. https://docs.onsched.com/v1.0 — external v1 object and endpoint reference.
4. [`test-apps/v1-compat/README.md`](/home/unbalanced/Development/OnSched/v3/test-apps/v1-compat/README.md) — manual flows and risk notes.

## Architecture walk

1. Request hits [`api/routes/consumer.js`](/home/unbalanced/Development/OnSched/v3/api/routes/consumer.js) or [`api/routes/setup.js`](/home/unbalanced/Development/OnSched/v3/api/routes/setup.js) under `/consumer/v1` or `/setup/v1`.
2. [`api/utils/auth/parseV1Token.js`](/home/unbalanced/Development/OnSched/v3/api/utils/auth/parseV1Token.js) establishes `req.v1Auth` (decoded token, sandbox/prod alignment).
3. Controller forwards to service layer; company may be resolved or **lazily** created on first use (see guide).
4. Shim obtains a **v3** OAuth token server-side and calls [`api/services/v3ApiClient.js`](/home/unbalanced/Development/OnSched/v3/api/services/v3ApiClient.js) against `/v3/*`.
5. [`api/services/v1ShimTranslator.js`](/home/unbalanced/Development/OnSched/v3/api/services/v1ShimTranslator.js) + [`api/services/v1Shim/shared.js`](/home/unbalanced/Development/OnSched/v3/api/services/v1Shim/shared.js) map requests/responses to v1-shaped JSON.

## Allowlist + 410 invariant

- Only method+path pairs registered on the routers are supported; everything else returns **410 Gone** with deprecation messaging.
- Changing routes requires updating the **Full path inventory** in [`v1AliasEndpoints.md`](/home/unbalanced/Development/OnSched/v3/rdme/docs/GetStarted/v1AliasEndpoints.md) in the **same commit**.
- Add or extend **integration tests** when behavior is non-trivial (`api/tests/integration/`).

## ID translation conventions

- Prefer resolving incoming IDs through [`api/services/legacyIdMapService.js`](/home/unbalanced/Development/OnSched/v3/api/services/legacyIdMapService.js) and model **`legacyId`** fields.
- Accept legacy string IDs where the shim already does; UUIDs may work for many handlers — verify against existing translator paths.
- Do not leak internal mapping tables in API responses unless already documented customer-visible fields.

## Compatibility-only mindset

- This layer is **temporary**: bridge customers to v3 runtime while they move to native `/v3/*`.
- **Do not** implement new v3 product features just to satisfy unsupported v1 endpoints or retired v1 fields.
- For weak-alignment areas (service groups, regions, customer custom-field schema, holidays, webhooks/payments/calendar placeholders), follow existing stub/empty/reduced patterns in [`v1AliasEndpoints.md`](/home/unbalanced/Development/OnSched/v3/rdme/docs/GetStarted/v1AliasEndpoints.md).

## Known shape quirks

- Setup **POST/PUT** for locations/services/resources often returns the **v1 entity object directly** (not the v3 `success`/`data` envelope).
- Location lists may force **`primaryBusiness: true`** on one item for legacy bootstrap.
- `GET …/availability/…/unavailable` depends on **legacy v1** behavior (proxied) — higher regression risk than core availability.

## Debug and tests

- Env: `LOG_V1_SHIM` — [`api/utils/logging/verboseLog.js`](/home/unbalanced/Development/OnSched/v3/api/utils/logging/verboseLog.js) (`logV1ShimDebug`).
- Manual: [`test-apps/v1-compat/`](/home/unbalanced/Development/OnSched/v3/test-apps/v1-compat).
- Search tests for `v1`, `shim`, `consumer`, `setup` under `api/tests/`.

## Handoff before finishing

- Path inventory doc updated if routes changed.
- User-visible HTTP changes -> skill **onsched-versioning**, **onsched-rdme-docs** as needed; regen OpenAPI if `/v3/*` contracts or annotations changed (`node rdme/endpoints/generate-openapi.js`).
- Multi-layer work → skill **onsched-agent-handoff**.
