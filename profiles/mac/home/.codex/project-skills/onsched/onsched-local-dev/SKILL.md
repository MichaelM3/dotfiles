---
name: onsched-local-dev
description: >-
  OnSched V3 local Docker: container names, ports, compose paths, and optional psql via docker exec (EXPLAIN ANALYZE, indexes, ad hoc SQL). Use for docker-compose, onsched-postgres, onsched-redis, onsched-api, onsched-app.
---

# OnSched V3 — Local Docker

## When to load this skill

- Starting or verifying the local Docker stack.
- You need container names, ports, or compose-file locations.
- You need `psql` or `redis-cli` against the same services the API uses.
- Gatling or availability debugging depends on local Postgres/Redis.

| Name               | Port |
| ------------------ | ---- |
| `onsched-postgres` | 5432 |
| `onsched-redis`    | 6379 |
| `onsched-api`      | 3001 |
| `onsched-app`      | 3000 |

Compose files: `api/docker-compose.yml`, `app/docker-compose.yml`

Connection settings for the API and CLI: `PG_USER`, `PG_PASSWORD`, `PG_DATABASE`, `PG_HOST`, `PG_PORT` — see [`api/database/config.js`](/home/unbalanced/Development/OnSched/v3/api/database/config.js) and your `api/.env` / `api/.env.dev` (do not commit secrets).

## Postgres in the `onsched-postgres` container

Use this when you need **`psql`** on the same server the API uses (e.g. **`EXPLAIN (ANALYZE, BUFFERS)`**, listing indexes, verifying a query). Host `psql` against `localhost:5432` works too if credentials match; **`docker exec`** avoids DB name / user drift with the container.

```bash
# Replace <db_name> with PG_DATABASE from your local env (often in api/.env)
docker exec -it onsched-postgres psql -U postgres -d <db_name>
```

Handy in `psql`:

- `\conninfo` — current database and user
- `\d "Appointment"` — describe a table (PascalCase identifiers are quoted in this project)
- `\di` — indexes (filter with optional pattern)
- Run analysis: `EXPLAIN (ANALYZE, BUFFERS) <your sql>;`

For **availability** SQL, match binds and fragments to the real query or results are misleading — see **onsched-availability-debug** (EXPLAIN section).

## Redis (optional)

```bash
docker exec -it onsched-redis redis-cli
```

## Gatling load tests

For **`onsched_gatling`**: stop **`onsched-api`** if it is using 3001, keep Postgres/Redis up, then run the API on the host with `ENV=gatling` and `npm run dev` from `api/` (see **onsched-gatling**).
