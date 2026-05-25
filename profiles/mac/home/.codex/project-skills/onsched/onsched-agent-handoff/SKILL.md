---
name: onsched-agent-handoff
description: >-
  Runs the start, middle, and end checklist for multi-step OnSched tasks; may use cavecrew subagent presets when delegation is explicitly authorized and caveman-compress for long markdown notes; runs verify-plan after a written plan before implementation. Use when changes span route/controller/service/validation/schema/docs/app/release artifacts, when v1 compatibility path inventory or migration coverage changes, or before marking a cross-layer task complete.
---

# OnSched - Multi-Step Task Handoff

## When To Load

- A change spans route, controller, service, validation, schema, tests, docs, or
  app files.
- Work is user-visible and may need OpenAPI, changelog, or Changeset follow-up.
- Availability, cache invalidation, error behavior, or glossary terms may change.
- V1 shim route inventory, translator behavior, or migration entity coverage
  changes.
- You are about to call a cross-layer task done.

## Related Skills

- Release policy: `onsched-versioning`.
- Public docs: `onsched-rdme-docs`.
- Plan gate: `verify-plan` after a written plan, before first implementation edit.
- Optional terse delegation: `cavecrew`, only when the user explicitly authorizes
  delegation or parallel agent work.
- Long natural-language markdown notes: `caveman-compress`; never use it on source,
  JSON, YAML, env, SQL, or shell files.

## Start

1. List touched layers: route, controller, service, validation, schema, OpenAPI,
   tests, docs, changelog, app.
2. Load the focused domain skill(s) for those layers.
3. If a written implementation plan exists and production edits have not started,
   load `verify-plan` and resolve its verdict first.
4. For broad discovery, use `cavecrew` investigator subagents only when delegation
   is allowed by the user.
5. Load `onsched-versioning` if the work is user-visible or touches OpenAPI,
   Changesets, changelog, schema, or release artifacts.
6. Apply the native error-handling guidance from `onsched-v3` if controller,
   service, validation, exception, or logging behavior changes.

## Middle

- Keep adjacent layers in sync; do not stop at the first compiling file.
- When fields, enums, responses, or statuses change, inspect validations, schemas,
  docs, tests, and OpenAPI before moving on.
- When work affects availability, confirm cache invalidation.
- When terminology changes, note glossary and changelog impact while fresh.

## V1 Compatibility Triggers

- Alias shim path inventory: `api/routes/consumer.js`, `api/routes/setup.js`, and
  `rdme/docs/GetStarted/v1AliasEndpoints.md`.
- Translator behavior: `api/services/v1ShimTranslator.js`,
  `api/services/v1ShimService.js`, `api/services/v1SetupShimService.js`.
- Migration entity or field coverage: `api/services/v1MigrationService.js`,
  `api/services/v1Migration/**`.

## End

1. Optional `cavecrew-reviewer` pass on final diff or hot paths when authorized and
   useful.
2. Confirm route/controller/service/validation/schema parity where contracts
   changed.
3. Confirm error/status behavior matches native `onsched-v3` guidance.
4. Confirm tests were added, updated, run, or explicitly scoped.
5. For public docs, verify claims against controllers, validations, schemas, and
   OpenAPI; use `onsched-rdme-docs` template.
6. Regenerate `rdme/endpoints/openapi.json` if OpenAPI sources changed.
7. Add a Changeset when work is user-visible.
8. Add/update `rdme/changelog/` when customers or integrators should hear about it.
9. Update `rdme/docs/Glossary/terms.md` when customer-facing terminology changes.

## Stop And Ask

Stop instead of guessing when code/tests/docs disagree, release-artifact decisions
are unclear, or auth/logging safety is uncertain.
