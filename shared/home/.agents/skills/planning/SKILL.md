---
name: planning
description: Route planning requests to focused skills. Use when the user asks for a PRD, issue breakdown, implementation plan, feature breakdown, or design grilling and the right planning skill is not yet obvious.
---

# Planning

Choose the smallest focused skill that matches the request.

## Route

- Unsure which Matt-style flow fits -> `ask-matt`.
- PRD/spec document -> `to-prd`.
- Implementation tickets/issues -> `to-issues`.
- Execute an approved PRD/issue/plan -> `implement`.
- Pure design interview -> `grill-me`.
- Design interview that should preserve domain vocabulary or ADRs -> `grill-with-docs`.
- Verify an existing implementation plan against repo evidence -> `verify-plan`.
- Understand system shape before planning -> `zoom-out`.

## Default

If the user asks for a generic implementation plan:

1. Inspect only enough repo context to avoid generic advice.
2. Produce a concise, file-oriented plan with acceptance checks.
3. Use `verify-plan` before editing.

Do not publish tracker artifacts unless the user asks.
