---
name: onsched-gatling
description: >-
  OnSched Gatling JS load tests for GET /v3/availability: onsched_gatling database, seeders-gatling, smoke/stress profiles, GATLING_PROFILE, ENV=gatling, reports under gatling/javascript/target. Use when working with Gatling, load testing, stress testing, availability performance, feeder CSVs, or api/gatling.
---

# OnSched — Gatling load testing

- **API guidance:** native `onsched-v3` API, workflow, and availability sections.
- **Canonical reference:** `api/gatling/README.md`

## When to load this skill

- Running or editing Gatling for `GET /v3/availability`.
- Resetting or seeding the `onsched_gatling` database.
- Switching the API to `ENV=gatling` and freeing port `3001`.
- Interpreting throughput or latency results against availability behavior.

## Purpose

Stress-test **`GET /v3/availability`** using Gatling JS (`@gatling.io/core`, `@gatling.io/http` in `api/gatling/javascript/package.json`) against a dedicated Postgres database **`onsched_gatling`** with seeded tenant diversity (many companies, multiple IAN timezones, mixed schedule archetypes, allocations, unavailability, feeder CSVs generated under `api/gatling/javascript/resources/`).

## One-time setup

From `api/`:

```bash
npm install
npm --prefix ./gatling/javascript install
```

## Config

- Defaults and load profiles: `api/gatling/javascript/src/config.js` (e.g. `BASE_URL` toward `http://127.0.0.1:3001`).
- Local overrides: optional `api/gatling/javascript/src/config.local.js` (gitignored when present), or shell env `GATLING_BASE_URL` / `GATLING_PROFILE`. Under `gatling run`, reads use `getEnvironmentVariable` from `@gatling.io/core` first, then `process.env`. Confirm the log line `[GatlingAvailability] profile=smoke|stress`. Optional: `cd gatling/javascript && npx gatling run GATLING_PROFILE=smoke --simulation onsched`.

## Database

Reset and seed **`onsched_gatling`** (uses `.env.gatling` and `database/seeders-gatling`):

```bash
cd api && npm run gatling:db:reset
```

## Run API against the Gatling DB

Docker: keep **`onsched-postgres`** and **`onsched-redis`** up; **`docker stop onsched-api`** if it is running so host port **3001** is free. Then from `api/` on the host:

```bash
export ENV=gatling
npm run dev
```

## Run load tests

From `api/` — run **smoke** first, then **stress** if smoke is clean:

```bash
npm run gatling:availability:smoke
npm run gatling:availability:stress
```

`GATLING_PROFILE=smoke|stress` controls ramp/plateau/burst (see `api/gatling/javascript/package.json` scripts).

## Reports

HTML and assets are written under `api/gatling/javascript/target/gatling/` (`target/` is generated; do not treat as source).

## Related skills

- **onsched-local-dev** — Docker container names, ports, compose for Postgres/Redis locally.
- In Codex sandboxes, use normal command escalation if local service startup or
  dependency install needs permissions outside the workspace; keep `PG_*` and
  `ENV` aligned with `onsched_gatling`.
- **onsched-availability-debug** — availability engine behavior, `DEBUG_LOGS`, slot validation — useful if you need to interpret failures or tune scenarios beyond raw throughput.
