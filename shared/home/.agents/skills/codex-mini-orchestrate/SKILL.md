---
name: codex-mini-orchestrate
description: Codex adapter for bounded implementation orchestration. Use only when the user explicitly asks for Codex mini-orchestrate or asks this harness to coordinate Codex subagents for an approved implementation plan.
---

# Codex Mini-Orchestrate

Harness adapter. Keep the main thread in charge; delegate only bounded tasks.

## Preconditions

- User approved the goal and scope.
- Work is too large for a direct single-thread edit.
- Subagents are allowed by user/session policy.

For generic delegation rules, load `sub-agent-capabilities`.

## Flow

1. Restate goal, constraints, acceptance criteria, and non-goals.
2. Delegate repo/context discovery only if edit sites are unclear.
3. Delegate one vertical implementation slice at a time.
4. Verify with focused commands.
5. Review changed files against acceptance criteria.
6. Loop only must-fix findings.
7. Final response: changed files, verification, review status, remaining risk.

## Progressive Detail

Read only when needed:

- `references/ROLES.md` for Codex role/model mapping.
- `references/PROMPTS.md` for compact delegation prompt shapes.

Do not use for narrow single-file fixes.
