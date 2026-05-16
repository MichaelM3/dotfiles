---
name: verify-plan
description: >-
  After drafting an implementation plan (or when user asks to stress-test a plan), agent re-reads plan against repo evidence: lists assumptions, explores codebase for answerable gaps, asks user only for product/strategy blockers, then emits Plan verified or Plan needs revision with concrete fixes. Use before first code edit when plan mode produced a plan.
---

# Verify plan

Inspired by [Matt Pocock grill-me](https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-me/SKILL.md): stress-test a design. The agent grills its own plan, not the user, unless something is unknowable from code/docs.

## When to load

- Right after you output a structured plan and before `apply_patch` / implementation.
- User says: verify plan, stress-test plan, sanity-check plan, `/verify-plan`.
- Large or cross-layer change: pair with **onsched-agent-handoff** and optional **cavecrew** reviewer pass.

## Workflow

1. **Restate** goal + acceptance criteria in short bullets (what “done” means).
2. **Assumption audit** — list every implicit assumption (auth, idempotence, cache, migrations, API contract, app vs API, v1 shim, docs/OpenAPI).
3. **Evidence pass** — for each assumption answerable from repo: read rules, grep, read files; resolve or flag with `path:line`.
4. **User questions** — ask **one question at a time** only when product choice, missing secret/env, or irreversible scope is blocking; offer a recommended default when possible.
5. **Verdict**
   - **`Plan verified`** — gaps closed or explicitly out of scope; list residual risks in one short block.
   - **`Plan needs revision`** — numbered fixes (each actionable: file area, rule, or decision); do not start implementation until user confirms or you merge fixes into the plan.

## Output contract

Keep under tight token budget unless user asked for depth:

```text
## Verify-plan summary
Goal: …
Assumptions checked: N (resolved: …)
Open questions (user): … | none

## Verdict
Plan verified | Plan needs revision
…
```

## Boundaries

- Do not substitute for **onsched-versioning** / **onsched-rdme-docs** checklists at ship time — this skill is **pre-build** plan quality.
- Do not invent API behavior: if code/docs disagree, **stop and ask** per **onsched-agent-handoff**.
- Security / irreversible steps: plain-language warning when relevant (see **caveman** Auto-Clarity).

## Related

- Multi-step completion: **onsched-agent-handoff** (`/home/unbalanced/.codex/skills/onsched-agent-handoff/SKILL.md`).
- Parallel locate/review: **cavecrew** (`/home/unbalanced/.codex/skills/cavecrew/SKILL.md`).
